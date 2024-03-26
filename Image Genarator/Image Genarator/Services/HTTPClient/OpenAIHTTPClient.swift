//
//  OpenAIHTTPClient.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 20.03.2024.
//

import Foundation

class OpenAIHTTPClient: HTTPClient {
    /// API scheme
    let scheme: String = "https"
    
    /// API host
    let host: String
    
    /// API version
    let apiVersion: String
    
    /// Port
    let port: Int? = nil
    
    /// Access token
    var accessToken: String? {
        APIUrls.openAIAccessToken
    }
    
    /// Refresh token
    var refreshToken: String?
    
    /// URLSession for executing requests
    internal var session: URLSession
    
    /// Active data task
    internal var task: URLSessionDataTask?
    
    /// Active request
    internal var request: URLRequest?
    
    /// Preset retries count
    var presetRetryCount: Int
    
    /// Preset refresh access token retries counter
    var presetRefreshTokenRetryCount: Int
    
    /// Preset timeout in seconds
    var presetTimeout: Double = 30
    
    /// Retry counter
    private(set) var retryCounter: Int
    
    /// Refresh access token retries counter
    private(set) var refreshTokenRetryCounter: Int
        
    
    var notAuthorizedHandler: NotAuthorizedHandler?
    var serverErrorHandler: ServerErrorHandler?
    var setAuthorizationTokenHandler: SetAuthorizationTokenHandler?
    var refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler?
    
    
    // MARK: - Init
    
    init(host: String,
         apiVersion: String,
         retryCount: Int = 0,
         refreshTokenCount: Int = 0,
         notAuthorizedHandler: NotAuthorizedHandler?,
         serverErrorHandler: ServerErrorHandler?,
         setAuthorizationTokenHandler: SetAuthorizationTokenHandler?,
         refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler?) {
        self.host = host
        self.apiVersion = apiVersion
        self.presetRetryCount = retryCount
        self.retryCounter = presetRetryCount
        self.presetRefreshTokenRetryCount = refreshTokenCount
        self.refreshTokenRetryCounter = presetRefreshTokenRetryCount
        self.notAuthorizedHandler = notAuthorizedHandler
        self.serverErrorHandler = serverErrorHandler
        self.setAuthorizationTokenHandler = setAuthorizationTokenHandler
        self.refreshAuthorizationTokenHandler = refreshAuthorizationTokenHandler
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = presetTimeout
        config.waitsForConnectivity = true
        
        session = URLSession(configuration: config)
    }
    
    // MARK: - Deinit
    
    deinit {
        session.invalidateAndCancel()
    }
    
//    private let apiURL: String
//    private let clientToken: String
//
//    init(apiURL: String,
//         clientToken: String) {
//        self.apiURL = apiURL
//        self.clientToken = clientToken
//    }
    
    // MARK: - Logging
    
    func logRequest(_ request: URLRequest) {
        
    }
    
    func logResponse(_ response: URLResponse?, data: Data?, error: Error?) {
        
    }
}
