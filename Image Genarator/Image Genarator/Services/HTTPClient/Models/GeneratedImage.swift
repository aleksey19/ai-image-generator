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
        let urlString = try container.decode(String.self, forKey: .url)
        
        guard let url = URL(string: urlString)
        else { throw AppError.server("Can't compose image url from string while decoding: \(urlString)") }
        
        self.url = url
        self.revisedPrompt = try container.decode(String.self, forKey: .revisedPrompt)
    }
}

extension GeneratedImage: Decodable {
    public enum CodingKeys: String, CodingKey {
        case url
        case revisedPrompt = "revised_prompt"
    }
}
