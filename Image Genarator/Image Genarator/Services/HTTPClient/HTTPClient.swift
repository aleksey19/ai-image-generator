//
//  HTTPClient.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

protocol HTTPClient: AnyObject {
    var scheme: String { get }
    var host: String { get }
    var apiVersion: String { get }
    var port: Int? { get }
    var accessToken: String? { get }
    var refreshToken: String? { get }
    
    var session: URLSession { get }
    var task: URLSessionDataTask? { get set }
    var request: URLRequest? { get set }
    
    var presetRetryCount: Int { get }
    var presetRefreshTokenRetryCount: Int { get }
    var presetTimeout: Double { get }
    var retryCounter: Int { get }
    var refreshTokenRetryCounter: Int { get }
    
    func makeURLRequest(_ request: HTTPRequest) throws -> URLRequest?
    func composeRequestHeaders() -> [String: String]
    func runWithRetry<T: Decodable>(_ request: URLRequest) async throws -> T
    
    func logRequest(_ request: URLRequest)
    func logResponse(_ response: URLResponse?, data: Data?, error: Error?)
    
    func resetRetryConuter()
    func decrementRetryConuter()
    
    func resetRefreshTokenConuter()
    func decrementRefreshTokenConuter()
    
    
    typealias NotAuthorizedHandler = (() -> Void)
    typealias ServerErrorHandler = ((String) -> Void)
    typealias SetAuthorizationTokenHandler = ((_ token: String, _ refreshToken: String) -> Void)
    typealias RefreshAuthorizationTokenHandler = (() -> Void)
    
    var notAuthorizedHandler: NotAuthorizedHandler? { get }
    var serverErrorHandler: ServerErrorHandler? { get }
    var setAuthorizationTokenHandler: SetAuthorizationTokenHandler? { get }
    var refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler? { get }
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
        urlComponents.path = "/".appending(apiVersion.appending(request.path))
        
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
    
    func resetRetryConuter() { }
    func decrementRetryConuter() { }
    
    func resetRefreshTokenConuter() { }
    func decrementRefreshTokenConuter() { }
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
        
        // Authorize to view this resource
        if statusCode == 401 {
            if accessToken != nil {
                return try await refreshToken()
            } else {
//                notAuthorizedHandler?()
                throw AppError.server("401 error")
            }
        }
        
        // Update application to view this resource
        if statusCode == 426 {
            let error = NSError(domain: "HTTPResponseError",
                                code: statusCode,
                                userInfo: [NSLocalizedDescriptionKey: "Application version outdated. Please update the application!"])
            serverErrorHandler?(error.localizedDescription)
            throw error
        }
        
        // Handle 204 code (request succeded but returned empty response)
        if statusCode == 204 {
        }
        
        // Handle error object
//        if let errorObject = try? JSONDecoder().decode(ResponseObjectWithError.self, from: data),
//           let error = errorObject.localizedError {
//            throw error
//        }
        
        // If execution reaches here request has finished with 200 code
        if refreshTokenRetryCounter != presetRefreshTokenRetryCount {
            resetRefreshTokenConuter()
        }
        
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
                            
            return object
        } catch let error {
            AppLogger.shared.log(error: error)
            
            /// Print for test purpose
            let json = String(data: data, encoding: .utf8)
            let code = statusCode
            
            debugPrint(code)
            debugPrint(json ?? "-")
            ///
            
            throw error
        }
    }
}

// MARK: - Refresh token

extension HTTPClient {
    
    /**
     Refreshes authorisation token.
     If refresh fails or refresh count expires then execute `notAuthorizedHandler` (redirects to sign in).
     */
    private func refreshToken<T: Decodable>() async throws -> T {
        guard let refreshToken = refreshToken else {
            throw AppError.develop("Can't renew authorisation token because refresh token is nil")
        }
        
        guard refreshTokenRetryCounter > 0 else {
            notAuthorizedHandler?()
            throw AppError.server("Can't refresh authorisation token. Refresh tries expired")
        }
        
        decrementRefreshTokenConuter()
        
        throw AppError.develop("Finish retry func")
        
//        let body = RefreshTokenRequestBody(refreshToken: refreshToken,
//                                           clientId: ConfigLoader.parseConfig().clientID,
//                                           clientSecret: ConfigLoader.parseConfig().clientSecret)
//        let request = RefreshTokenRequest(body: body)
//
//        if let urlRequest = try makeURLRequest(request),
//           var failedRequest = self.request {
//            let refreshTokenResponse: RefreshTokenResponse = try await run(urlRequest)
//            if let data = refreshTokenResponse.data {
//                // Save new token
//                setAuthorizationTokenHandler?(data.token, data.refreshToken)
//                // Retry failed request
//                failedRequest.allHTTPHeaderFields?["Authorization"] = "Bearer " + data.token
//                let response: T = try await runWithRetry(failedRequest)
//
//                return response
//            } else {
//                throw AppError.server("Refresh token request returned empty data")
//            }
//        } else {
//            throw AppError.develop("Can't renew authorisation token because can't construct request or can't find failed request")
//        }
    }
}
