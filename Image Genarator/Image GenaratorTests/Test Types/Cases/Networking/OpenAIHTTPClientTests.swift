//
//  OpenAIHTTPClientTests.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 29.05.2024.
//

import XCTest
@testable import Image_Genarator

final class OpenAIHTTPClientTests: XCTestCase {

    var session: MockUrlSession!
    var sut: OpenAIHTTPClient!
    var notAuthorizedHandlerExecuted: Bool = false
    var serverErrorHandlerExecuted: Bool = false
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        session = MockUrlSession()
        sut = .init(session: session,
                    host: "test.com",
                    apiVersion: "",
                    retryCount: 3,
                    notAuthorizedHandler: { self.notAuthorizedHandlerExecuted = true },
                    serverErrorHandler: { self.serverErrorHandlerExecuted = true },
                    setAuthorizationTokenHandler: nil,
                    refreshAuthorizationTokenHandler: nil,
                    connectionStateChangedHandler: nil)
    }

    override func tearDownWithError() throws {
        session = nil
        sut = nil
        notAuthorizedHandlerExecuted = false
        serverErrorHandlerExecuted = false
        try super.tearDownWithError()
    }

    // MARK: - When
    
    func whenExecuteCreateImageRequest(
        statusCode: Int = 200,
        data: Data? = nil,
        error: Error? = nil
    ) async throws -> OpenAICreateImageResponse {
        let response = HTTPURLResponse(url: URL(string: sut.host!)!,
                                       statusCode: statusCode,
                                       httpVersion: nil,
                                       headerFields: nil)
        session.set(urlResponse: response,
                    responseData: data,
                    error: error)
        let request = OpenAICreateImageRequest()
        return try await sut.execute(request)
    }
    
    // MARK: - Tests
    
    func test_init_setsSession() {
        XCTAssertTrue(sut.session === session)
    }
    
    func test_OpenAIClient_composesValidURLRequest() throws {
        // given
        let query = URLQueryItem(name: "query", value: "some")
        let body = "Some body"
        let request = MockHTTPRequest(query: [query], body: body)
        let urlRequest = try sut.makeURLRequest(request)
        // then
        XCTAssertNotNil(urlRequest)
        XCTAssertNotNil(urlRequest?.url)
        XCTAssertEqual(urlRequest?.url?.host(), sut.host)
        XCTAssertNotNil(urlRequest?.value(forHTTPHeaderField: "Authorization"))
        XCTAssertNotNil(urlRequest?.url?.query())
        XCTAssertNotNil(urlRequest?.httpBody)
    }
    
    func test_OpenAIClient_whenCantConstructURLRequest_throwsWrongUrlError() throws {
        // given
        let request = MockHTTPRequestInvalidPath()
        // Set host to nil to provoke throwing an error when composing an URLRequest
        sut.host = nil
        let givenError = AppError.develop("Error while composing request URL")
        
        do {
            let _ = try sut.makeURLRequest(request)
        } catch {
            XCTAssertEqual(givenError.localizedDescription, error.localizedDescription)
        }
    }
    
    func test_OpenAIClient_whenGot500Error_throwsError() async {
        await XCTAssertThrowsError_Async(try await whenExecuteCreateImageRequest(statusCode: 500))
    }
    
    func test_OpenAIClient_whenGot500Error_executesServerErrorHandler() async {
        _ = try? await whenExecuteCreateImageRequest(statusCode: 500)
        XCTAssertTrue(serverErrorHandlerExecuted)
    }
    
    func test_OpenAIClient_whenGot401Error_executesNotAuthorizedHandler() async {
        _ = try? await whenExecuteCreateImageRequest(statusCode: 401)
        XCTAssertTrue(notAuthorizedHandlerExecuted)
    }
    
    func test_OpenAIClient_whenGotUnknownErrorCode_throwsError() async {
        // given
        let statusCode = 426
        let givenError = "Server error, code: \(statusCode)"
        // when
        do {
            _ = try await whenExecuteCreateImageRequest(statusCode: statusCode)
        } catch {
            // then
            XCTAssertEqual(givenError, error.localizedDescription)
        }
    }
    
    func test_OpenAIClient_whenExecutesRequestAndCantComposeURL_throwsError() async {
        // given
        let request = MockHTTPRequestInvalidPath()
        // Set host to nil to provoke throwing an error when composing an URLRequest
        sut.host = nil
        
        await XCTAssertThrowsError_Async(try await sut.execute(request, responseType: OpenAICreateImageResponse.self))
    }
    
    func test_OpenAIClient_whenCantDecodeJSON_throwsDecodingError() async throws {
        let data = try Data.fromJSON(fileName: "CreateImageResponse_WrongKey")
        do {
            let _ = try await whenExecuteCreateImageRequest(data: data)
            XCTFail("Should fail")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func test_OpenAIClient_handlesCreateImageResponseJSON() async throws {
        // given
        let data = try Data.fromJSON(fileName: "CreateImageResponse")
        let decoder = JSONDecoder()
        let givenResponse = try decoder.decode(OpenAICreateImageResponse.self, from: data)
        
        do {
            let response = try await whenExecuteCreateImageRequest(data: data)
            XCTAssertEqual(givenResponse, response)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    // MARK: - Retry counter tests
    
    func test_OpenAIClient_decrementsRetryCounter() {
        // given
        let givenCounter = sut.retryCounter
        // when
        sut.decrementRetryConuter()
        // then
        XCTAssertEqual(sut.retryCounter, givenCounter - 1)
    }
    
    func test_OpenAIClient_resetsRetryCounter() {
        // given
        sut.decrementRetryConuter()
        sut.decrementRetryConuter()
        // when
        sut.resetRetryConuter()
        // then
        XCTAssertEqual(sut.retryCounter, sut.presetRetryCount)
    }
}

extension Image_Genarator.OpenAIHTTPClient {
    func execute<T: Decodable>(_ request: HTTPRequest, responseType: T.Type) async throws -> T {
        let result: T = try await self.execute(request)
        return result
    }
}
