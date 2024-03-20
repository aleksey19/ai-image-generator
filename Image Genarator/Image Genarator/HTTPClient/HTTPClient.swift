//
//  HTTPClient.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 20.03.2024.
//

import Foundation

class HTTPClient {
    
    private let apiURL: String
    private let clientToken: String
    
    init(apiURL: String,
         clientToken: String) {
        self.apiURL = apiURL
        self.clientToken = clientToken
    }
}
