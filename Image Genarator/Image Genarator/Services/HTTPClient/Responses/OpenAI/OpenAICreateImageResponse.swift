//
//  OpenAICreateImageResponse.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

struct OpenAICreateImageResponse: Decodable, Equatable {
    let created: Int64
    let data: [OpenAICreateImageResponseImage]
}

struct OpenAICreateImageResponseImage: Equatable {
    let url: URL?
    let revisedPrompt: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let urlString = try container.decode(String.self, forKey: .url)
        
        guard let url = URL(string: urlString)
        else { throw AppError.server("Can't compose image url from string while decoding: \(urlString)") }
        
        self.url = url
        self.revisedPrompt = try? container.decode(String.self, forKey: .revisedPrompt)
    }
    
    init(url: URL?,
         prompt: String?) {
        self.url = url
        self.revisedPrompt = prompt
    }
}

extension OpenAICreateImageResponseImage: Decodable {
    public enum CodingKeys: String, CodingKey {
        case url
        case revisedPrompt = "revised_prompt"
    }
}
