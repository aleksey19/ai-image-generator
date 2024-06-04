//
//  MockHTTPRequest.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 29.05.2024.
//

import Foundation
@testable import Image_Genarator

struct MockHTTPRequest: HTTPRequest {
    let method: HTTPMethod = .get
    let path: String = "test"
    let query: [URLQueryItem]?
    let body: Encodable?
    
    init(query: [URLQueryItem]? = nil, body: Encodable? = nil) {
        self.query = query
        self.body = body
    }
}

struct MockHTTPRequestInvalidPath: HTTPRequest {
    let method: HTTPMethod = .get
    let path: String = "//test"
    let query: [URLQueryItem]?
    let body: Encodable?
    
    init(query: [URLQueryItem]? = nil, body: Encodable? = nil) {
        self.query = query
        self.body = body
    }
}
