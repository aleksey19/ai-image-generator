//
//  CreateImageResponse.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

struct CreateImageResponse: Decodable {
    let created: Int64
    let data: [GeneratedImage]
}
