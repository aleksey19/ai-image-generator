//
//  StableDiffusionCreateImageRequest.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.06.2024.
//

import Foundation

struct StableDiffusionCreateImageRequest: HTTPRequest {
    let method: HTTPMethod = .post
    let path: String = "text2img"
    let query: [URLQueryItem]?
    let body: Encodable?
    
    init(query: [URLQueryItem]? = nil, body: Encodable? = nil) {
        self.query = query
        self.body = body
    }
}
