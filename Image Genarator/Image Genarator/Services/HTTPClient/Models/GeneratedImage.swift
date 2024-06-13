//
//  GeneratedImage.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

struct GeneratedImage: Equatable {
    let url: URL?
    let revisedPrompt: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let urlString = (try? container.decodeIfPresent(String.self, forKey: .url)) ?? ""
        url = !urlString.isEmpty ? URL(string: urlString) : nil
        revisedPrompt = try? container.decodeIfPresent(String.self, forKey: .revisedPrompt)
    }
}

extension GeneratedImage: Decodable {
    public enum CodingKeys: String, CodingKey {
        case url
        case revisedPrompt = "revised_prompt"
    }
}
