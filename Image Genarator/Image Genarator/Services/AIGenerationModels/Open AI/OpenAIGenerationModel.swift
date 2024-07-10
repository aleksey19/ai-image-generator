//
//  OpenAIGenerationModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.06.2024.
//

import Foundation
import UIKit.UIImage

final class OpenAIGenerationModel: AIGenerationModel {
    
    private unowned var httpClient: HTTPClient
    
    // MARK: - Init
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    // MARK: - Generate image
    
    func generateImage(prompt: String) async throws -> GeneratedImage {
        /// Credits saving parameters
        /// Prices here: https://openai.com/api/pricing/
        let model = "dall-e-2"
        let size = "256x256"
        let body = OpenAICreateImageRequestBody(prompt: prompt, model: model, n: 1, size: size, style: nil)
        let request = OpenAICreateImageRequest(body: body)
        let response: OpenAICreateImageResponse = try await httpClient.execute(request)
        
        return CreateImageResponseMapper.map(response: response)
    }
}
