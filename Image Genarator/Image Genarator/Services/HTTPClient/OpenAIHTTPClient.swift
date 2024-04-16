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
    private(set) var refreshToken: String?
    
    /// URLSession for executing requests
    private(set) var session: URLSession
    
    /// Active data task
    var task: URLSessionDataTask?
    
    /// Active request
    var request: URLRequest?
    
    /// Preset retries count
    private(set) var presetRetryCount: Int
    
    /// Preset refresh access token retries counter
    private(set) var presetRefreshTokenRetryCount: Int
    
    /// Preset timeout in seconds
    private(set) var presetTimeout: Double = 60
    
    /// Retry counter
    private(set) var retryCounter: Int
    
    /// Refresh access token retries counter
    private(set) var refreshTokenRetryCounter: Int
        
    
    var notAuthorizedHandler: NotAuthorizedHandler?
    var serverErrorHandler: ServerErrorHandler?
    var setAuthorizationTokenHandler: SetAuthorizationTokenHandler?
    var refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler?
    var connectionStateChangedHandler: ConnectionStateChangedHandler?
    
    // MARK: - Init
    
    init(host: String,
         apiVersion: String,
         retryCount: Int = 0,
         refreshTokenCount: Int = 0,
         notAuthorizedHandler: NotAuthorizedHandler?,
         serverErrorHandler: ServerErrorHandler?,
         setAuthorizationTokenHandler: SetAuthorizationTokenHandler?,
         refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler?,
         connectionStateChangedHandler: ConnectionStateChangedHandler?) {
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
        self.connectionStateChangedHandler = connectionStateChangedHandler
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = presetTimeout
//        config.timeoutIntervalForResource = presetTimeout * 60
        config.waitsForConnectivity = true
//        config.allowsCellularAccess = true
//        config.allowsExpensiveNetworkAccess = true
        
        session = URLSession(configuration: config)
        
        startTrackingConnectionState()
    }
    
    // MARK: - Deinit
    
    deinit {
        session.invalidateAndCancel()
        stopTrackingConnectionState()
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
