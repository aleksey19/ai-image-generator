//
//  GeneratedImage.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

struct GeneratedImage {
    let url: String
    let revisedPrompt: String?
}

extension GeneratedImage: Decodable {
    public enum CodingKeys: String, CodingKey {
        case url
        case revisedPrompt = "revised_prompt"
    }
}
