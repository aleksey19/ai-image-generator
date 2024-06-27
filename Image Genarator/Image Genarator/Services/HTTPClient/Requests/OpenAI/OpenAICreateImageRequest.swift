//
//  OpenAICreateImageRequest.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

struct OpenAICreateImageRequest: HTTPRequest {
    let method: HTTPMethod = .post
    let path: String = "images/generations"
    let query: [URLQueryItem]?
    let body: Encodable?
    
    init(query: [URLQueryItem]? = nil, body: Encodable? = nil) {
        self.query = query
        self.body = body
    }
}
