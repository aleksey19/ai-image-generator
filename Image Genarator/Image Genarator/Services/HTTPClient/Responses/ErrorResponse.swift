//
//  ErrorResponse.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.06.2024.
//

import Foundation

struct ErrorResponse: Decodable {
    let error: ErrorObject
}

struct ErrorObject: Decodable {
    let code: String
    let message: String
}
