//
//  MockHTTPClient.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 29.05.2024.
//

import Foundation
@testable import Image_Genarator

final private class MockHTTPClient: HTTPClient {
    var scheme: String
    var host: String?
    var apiVersion: String?
    var port: Int?
    var accessToken: String?
    var refreshToken: String?
    
    var session: URLSessionProtocol
    var task: URLSessionDataTask?
    var request: URLRequest?
    
    var presetRetryCount: Int
    var presetRefreshTokenRetryCount: Int
    var presetTimeout: Double
    var retryCounter: Int
    var refreshTokenRetryCounter: Int
    
    var notAuthorizedHandler: NotAuthorizedHandler?
    var serverErrorHandler: ServerErrorHandler?
    var setAuthorizationTokenHandler: SetAuthorizationTokenHandler?
    var refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler?
    var connectionStateChangedHandler: ConnectionStateChangedHandler?
    
    
    init(scheme: String,
         host: String,
         apiVersion: String,
         port: Int? = nil,
         accessToken: String? = nil,
         refreshToken: String? = nil,
         session: URLSessionProtocol,
         task: URLSessionDataTask? = nil,
         request: URLRequest? = nil,
         presetRetryCount: Int = 1,
         presetRefreshTokenRetryCount: Int = 1,
         presetTimeout: Double = 1,
         retryCounter: Int = 1,
         refreshTokenRetryCounter: Int = 1,
         notAuthorizedHandler: NotAuthorizedHandler? = nil,
         serverErrorHandler: ServerErrorHandler? = nil, setAuthorizationTokenHandler: SetAuthorizationTokenHandler? = nil,
         refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler? = nil,
         connectionStateChangedHandler: ConnectionStateChangedHandler? = nil) {
        self.scheme = scheme
        self.host = host
        self.apiVersion = apiVersion
        self.port = port
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.session = session
        self.task = task
        self.request = request
        self.presetRetryCount = presetRetryCount
        self.presetRefreshTokenRetryCount = presetRefreshTokenRetryCount
        self.presetTimeout = presetTimeout
        self.retryCounter = retryCounter
        self.refreshTokenRetryCounter = refreshTokenRetryCounter
        self.notAuthorizedHandler = notAuthorizedHandler
        self.serverErrorHandler = serverErrorHandler
        self.setAuthorizationTokenHandler = setAuthorizationTokenHandler
        self.refreshAuthorizationTokenHandler = refreshAuthorizationTokenHandler
        self.connectionStateChangedHandler = connectionStateChangedHandler
    }
    
    func logRequest(_ request: URLRequest) { }
    
    func logResponse(_ response: URLResponse?, data: Data?, error: Error?) { }
}

final private class MockHTTPClientFactory {
    static func instance() -> MockHTTPClient {
        .init(scheme: "http",
              host: "example.com",
              apiVersion: "",
              session: MockUrlSession())
    }
}
