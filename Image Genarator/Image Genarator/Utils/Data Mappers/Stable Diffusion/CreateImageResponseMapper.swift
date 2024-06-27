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
        return GeneratedImage(url: url, prompt: response.meta.prompt)
    }
    
    static func map(response: OpenAICreateImageResponse) -> GeneratedImage {
        let data = response.data.first
        return GeneratedImage(url: data?.url, prompt: data?.revisedPrompt)
    }
}
