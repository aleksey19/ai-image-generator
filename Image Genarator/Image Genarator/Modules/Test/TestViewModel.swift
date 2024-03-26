//
//  TestViewModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

class TestViewModel: ObservableObject {
    
    private var httpClient: HTTPClient?
    
    // MARK: - Init
    
    init(httpClient: HTTPClient?) {
        self.httpClient = httpClient
    }
    
    // MARK: - Requests
    
    func createImage(with prompt: String) async throws -> CreateImageResponse? {
        let body = CreateImageRequestBody(prompt: prompt, model: nil, n: nil, size: nil, style: nil)
        let request = CreateImageRequest(body: body)
        
        let response: CreateImageResponse? = try await httpClient?.execute(request)
        return response
    }
}
