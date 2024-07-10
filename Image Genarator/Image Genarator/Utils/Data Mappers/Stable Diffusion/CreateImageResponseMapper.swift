//
//  CreateImageResponseMapper.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.06.2024.
//

import Foundation

final class CreateImageResponseMapper {
    static func map(response: StableDiffusionCreateImageResponse) -> GeneratedImage {
        let url = URL(string: response.output.first ?? "")
        return GeneratedImage(url: url, data: nil, prompt: response.meta.prompt)
    }
    
    static func map(response: OpenAICreateImageResponse) -> GeneratedImage {
        let data = response.data.first
        let base64Data = Data(base64Encoded: data?.base64String ?? "", options: .ignoreUnknownCharacters)
        return GeneratedImage(url: data?.url, data: base64Data, prompt: data?.revisedPrompt)
    }
}
