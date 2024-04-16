//
//  AppSession.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 19.03.2024.
//

import Foundation

final class AppSession: ObservableObject {
    
    static let shared = AppSession()
    
    lazy private(set) var openAIClient: HTTPClient = OpenAIHTTPClient(
        host: APIUrls.openAIApiURL,
        apiVersion: "v1",
        notAuthorizedHandler: nil,
        serverErrorHandler: nil,
        setAuthorizationTokenHandler: nil,
        refreshAuthorizationTokenHandler: nil,
        connectionStateChangedHandler: { status in
            DispatchQueue.main.async { [weak self] in
                self?.connectionIsReachable = status == .satisfied
            }
        }
    )
    
    @Published var connectionIsReachable: Bool = true
}
