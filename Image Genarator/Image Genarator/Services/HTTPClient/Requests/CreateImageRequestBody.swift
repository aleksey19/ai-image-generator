//
//  CreateImageRequestBody.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

struct CreateImageRequestBody: Encodable {
    let prompt: String
    let model: String?
    let n: Int?
    let size: String?
    let style: String?
}
