//
//  StableDiffusionHTTPClient.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.06.2024.
//

import Foundation

final class StableDiffusionHTTPClient: HTTPClient {
    /// API scheme
    let scheme: String = "https"
    
    /// API host
    var host: String?
    
    /// API version
    let apiVersion: String?
    
    /// Port
    let port: Int? = nil
    
    /// Access token
    /// For Stable Diffusion attach token to requests body
    var accessToken: String?  = nil
    
    /// Refresh token
    private(set) var refreshToken: String?
    
    /// URLSession for executing requests
    private(set) var session: URLSessionProtocol
    
    /// Active data task
    var task: URLSessionDataTask?
    
    /// Active request
    var request: URLRequest?
    
    /// Preset retries count
    private(set) var presetRetryCount: Int
    
    /// Preset timeout in seconds
    private(set) var presetTimeout: Double = 60
    
    /// Retry counter
    private(set) var retryCounter: Int
            
    
    var notAuthorizedHandler: NotAuthorizedHandler?
    var serverErrorHandler: ServerErrorHandler?
    var setAuthorizationTokenHandler: SetAuthorizationTokenHandler?
    var refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler?
    var connectionStateChangedHandler: ConnectionStateChangedHandler?
    
    // MARK: - Init
    
    init(session: URLSessionProtocol,
         host: String,
         apiVersion: String? = nil,
         retryCount: Int = 0,
         notAuthorizedHandler: NotAuthorizedHandler?,
         serverErrorHandler: ServerErrorHandler?,
         setAuthorizationTokenHandler: SetAuthorizationTokenHandler?,
         refreshAuthorizationTokenHandler: RefreshAuthorizationTokenHandler?,
         connectionStateChangedHandler: ConnectionStateChangedHandler?) {
        self.session = session
        self.host = host
        self.apiVersion = apiVersion
        self.presetRetryCount = retryCount
        self.retryCounter = presetRetryCount
        self.notAuthorizedHandler = notAuthorizedHandler
        self.serverErrorHandler = serverErrorHandler
        self.setAuthorizationTokenHandler = setAuthorizationTokenHandler
        self.refreshAuthorizationTokenHandler = refreshAuthorizationTokenHandler
        self.connectionStateChangedHandler = connectionStateChangedHandler
        
        startTrackingConnectionState()
    }
    
    // MARK: - Deinit
    
    deinit {
        session.invalidateAndCancel()
        stopTrackingConnectionState()
    }
    
    // MARK: - Retry counter
    
    func resetRetryConuter() {
        retryCounter = presetRetryCount
    }
    
    func decrementRetryConuter() {
        retryCounter -= 1
    }
    
    // MARK: - Logging
    
    func logRequest(_ request: URLRequest) {
        
    }
    
    func logResponse(_ response: URLResponse?, data: Data?, error: Error?) {
        
    }
}
