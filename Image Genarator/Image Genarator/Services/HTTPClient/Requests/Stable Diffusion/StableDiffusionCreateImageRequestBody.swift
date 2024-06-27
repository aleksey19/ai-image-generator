//
//  StableDiffusionCreateImageRequestBody.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.06.2024.
//

import Foundation

struct StableDiffusionCreateImageRequestBody: Encodable {
    let key: String
    let prompt: String
    let width: String = "1024"
    let height: String = "1024"
    let samples: String = "1"
}
