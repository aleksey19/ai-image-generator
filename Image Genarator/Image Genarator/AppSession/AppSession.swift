//
//  AppSession.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 19.03.2024.
//

import Foundation

final class AppSession: ObservableObject {
    
    lazy private(set) var openAIClient = HTTPClient(apiURL: "",
                                                    clientToken: APIUrls.openAIAccessToken)
    
}
