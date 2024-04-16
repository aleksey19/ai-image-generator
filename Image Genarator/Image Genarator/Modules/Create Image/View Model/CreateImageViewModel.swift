//
//  CreateImageViewModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.04.2024.
//

import Foundation
import SwiftUI

class CreateImageViewModel: ObservableObject {
    
    private weak var httpClient: HTTPClient?
    
    @MainActor
    @Published private(set) var imageUrl: URL? = nil
    
    @MainActor
    @Published private(set) var showLoading: Bool = false
    
    @MainActor
    @Published private(set) var error: AppError?
    
    // MARK: - Init
    
    init(httpClient: HTTPClient?) {
        self.httpClient = httpClient
    }
    
    // MARK: - Requests
    
    func createImage(with prompt: String) async {
        await MainActor.run {
            error = nil
            showLoading.toggle()
        }

        try? await Task.sleep(nanoseconds: 2000000000)
        
        await MainActor.run(body: {
            imageUrl = URL(string: "https://www.atlasandboots.com/wp-content/uploads/2019/05/ama-dablam2-most-beautiful-mountains-in-the-world.jpg")
//            error = .server("Can't generate image. Please try again later or change the prompt")
        })
        
//        let body = CreateImageRequestBody(prompt: prompt, model: nil, n: nil, size: nil, style: nil)
//        let request = CreateImageRequest(body: body)
//
//        do {
//            let response: CreateImageResponse? = try await httpClient?.execute(request)
//
//            if let urlString = response?.data.first?.url,
//               let url = URL(string: urlString) {
//                await MainActor.run(body: {
//                    imageUrl = url
//                })
//            }
//        } catch {
//            await MainActor.run {
//                self.error = .server(error.localizedDescription)
//            }
//        }

        await MainActor.run(body: {
            showLoading.toggle()
        })
    }
    
    @MainActor
    func cleanImage() {
        imageUrl = nil
    }
}
