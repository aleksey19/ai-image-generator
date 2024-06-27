//
//  StableDiffusionCreateImageResponse.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

struct StableDiffusionCreateImageResponse: Decodable, Equatable {
    let generationTime: Float
    let id: String
    let output: [String]
    let meta: StableDiffusionCreateImageResponseMeta
}

struct StableDiffusionCreateImageResponseMeta: Decodable, Equatable {
    let prompt: String
}
