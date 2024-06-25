//
//  HTTPClient.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation
import Network

protocol HTTPClient: AnyObject {
    var scheme: String { get }
    var host: String? { get }
    var apiVersion: String? { get }
    var port: Int? { get }
    var accessToken: String? { get }
    var refreshToken: String? { get }
    
    var session: URLSessionProtocol { get }
    var task: URLSessionDataTask? { get set }
    var request: URLRequest? { get set }
    
    var presetRetryCount: Int { get }
    var presetTimeout: Double { get }
    var retryCounter: Int { get }
    
    func makeURLRequest(_ request: HTTPRequest) throws -> URLRequest?
    func composeRequestHeaders() -> [String: String]
    func runWithRetry<T: Decodable>(_ request: URLRequest) async throws -> T
    
    func logRequest(_ request: URLRequest)
    func logResponse(_ response: URLResponse?, data: Data?, error: Error?)
    
    func resetRetryConuter()
    func decrementRetryConuter()
    
    
    typealias NotAuthorizedHandler = (() -> Void)
    typealias ServerErrorHandler = (() -> Void)
    typealias SetAuthorizationTokenHandler = ((_ token: String, _ refreshToken: String) -> Void)
    typealias RefreshAuthorizationTokenHandler = (() -> Void)
    typealias ConnectionStateChangedHandler = ((NWPath.Status) -> Void)
    
    var notAuthorizedHandler: NotAuthorizedHandler? { get }
    var serverErrorHandler: ServerErrorHandler? { get }
    var setAuthorizationTokenHandler: SetAuthorizationTokenHandler? { get }
    var refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler? { get }
    var connectionStateChangedHandler: ConnectionStateChangedHandler? { get }
}

// MARK: - Composing URLRequest

extension HTTPClient {
    
    func composeRequestHeaders() -> [String: String] {
        var headers = request?.allHTTPHeaderFields ?? [:]
        
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        
        if let token = accessToken {
            headers["Authorization"] = "Bearer " + token
        }
        
        return headers
    }
    
    func makeURLRequest(_ request: HTTPRequest) throws -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.port = port
        urlComponents.path = apiVersion.notEmpty ? "/".appending(apiVersion!.appending("/").appending(request.path)) : "/".appending(request.path)
        
        if let query = request.query {
            urlComponents.queryItems = query
        }
        
        if let url = urlComponents.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue.uppercased()
            urlRequest.allHTTPHeaderFields = composeRequestHeaders()
            
            if let body = request.body {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            }
            
            return urlRequest
        } else {
            throw wrongUrlError
        }
    }
    
    private var wrongUrlError: Error {
        AppError.develop("Error while composing request URL")
    }
    
//    func resetRetryConuter() { }
//    func decrementRetryConuter() { }
}

// MARK: - Methods

extension HTTPClient {
    
    func execute<T: Decodable>(_ request: HTTPRequest) async throws -> T {
        resetRetryConuter()
        
        do {
            self.request = try makeURLRequest(request)
            return try await runWithRetry(self.request!)
        } catch let error {
            AppLogger.shared.log(error: error)
            throw error
        }
    }
    
    func runWithRetry<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let response: T = try await run(request)
            return response
        } catch let error {
            decrementRetryConuter()
            
            if retryCounter > 0 {
                AppLogger.shared.log(info: "Retrying request \(request.url?.pathExtension ?? "")")
                
                return try await runWithRetry(request)
            } else {
                throw error
            }
        }
    }
    
    func run<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            let error = AppError.server("Unknown response type")
            throw error
        }
        
        if statusCode == 401 {
            notAuthorizedHandler?()
            throw AppError.server("Not authorized")
        }
        
        if statusCode == 500 {
            serverErrorHandler?()
            throw AppError.server("Internal server error")
        }
        
        guard statusCode == 200 else {
            if let errorObject = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw AppError.server(errorObject.error.message)
            } else {
                throw AppError.server("Server error, code: \(statusCode)")
            }
        }
        
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        }
//        catch let error as DecodingError {
//            AppLogger.shared.log(error: error)
//            throw AppError.decoding(error)
//        }
        catch {
            AppLogger.shared.log(error: error)
            throw error
        }
    }
}

// MARK: - Restart request after connection establishes

extension HTTPClient {
    
    func startTrackingConnectionState() {
        NetworkConnectionMonitor.shared.startTrackingConnectionState(with: connectionStateChangedHandler)
    }
    
    func stopTrackingConnectionState() {
        NetworkConnectionMonitor.shared.stopTrackingConnectionState()
    }
    
//    func restartFailedRequest<T: Codable>() async throws -> T {
//        if let request = self.request {
//            return try await runWithRetry(request)
//        }
//        throw AppError.develop("restartFailedRequest func still haven't been finished!")
//    }
}
