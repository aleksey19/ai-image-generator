//
//  AppSession.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 19.03.2024.
//

import Foundation

final class AppSession: ObservableObject {
    
    lazy private(set) var openAIClient = OpenAIHTTPClient(host: APIUrls.openAIApiURL,
                                                          apiVersion: "v1",
                                                          notAuthorizedHandler: nil,
                                                          serverErrorHandler: nil,
                                                          setAuthorizationTokenHandler: nil,
                                                          refreshAuthorizationTokenHandler: nil)
    
}
