//
//  StableDiffusionModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.06.2024.
//

import Foundation

final class StableDiffusionModel: AIGenerationModel {
    
    private unowned var httpClient: HTTPClient
    
    // MARK: - Init
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    // MARK: - Generate image
    
    func generateImage(prompt: String) async throws -> GeneratedImage {
        let body = StableDiffusionCreateImageRequestBody(key: APIUrls.stableDiffusionAccessToken, prompt: prompt)
        let request = StableDiffusionCreateImageRequest(body: body)
        let response: StableDiffusionCreateImageResponse = try await httpClient.execute(request)
        return StableDiffusionResponseMapper.map(response: response)
    }
}
