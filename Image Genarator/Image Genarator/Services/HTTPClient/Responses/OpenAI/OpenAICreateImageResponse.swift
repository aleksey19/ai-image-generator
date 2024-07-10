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
    let base64String: String?
    let revisedPrompt: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let urlString = try? container.decode(String.self, forKey: .url)
        self.url = urlString != nil ? URL(string: urlString!) : nil
        self.base64String = try? container.decode(String.self, forKey: .base64String)
        self.revisedPrompt = try? container.decode(String.self, forKey: .revisedPrompt)
    }
    
    init(url: URL?,
         base64String: String?,
         prompt: String?) {
        self.url = url
        self.base64String = base64String
        self.revisedPrompt = prompt
    }
}

extension OpenAICreateImageResponseImage: Decodable {
    public enum CodingKeys: String, CodingKey {
        case url
        case base64String = "b64_json"
        case revisedPrompt = "revised_prompt"
    }
}
