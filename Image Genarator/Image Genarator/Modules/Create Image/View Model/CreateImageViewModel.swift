//
//  CreateImageViewModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.04.2024.
//

import Foundation
import SwiftUI

final class CreateImageViewModel: ObservableObject {
    
    private weak var appSession: AppSession?
    private var generationModel: AIGenerationModel
    private(set) unowned var storedImagesManager: StoredImagesDataManager
    private(set) unowned var photoAlbumService: PhotoAlbumService
    
    @MainActor
    @Published private(set) var imageUrl: URL? = nil
    
    @MainActor
    @Published private(set) var imageData: Data? = nil
    
    @MainActor
    @Published private(set) var showLoading: Bool = false
    
    @MainActor
    @Published private(set) var error: AppError?
    
    // MARK: - Sheet options
    
    private(set) var imageStyles = ["Vivid", "Natural"]
    private(set) var imageSizes = ["1024x1024", "1792x1024", "1024x1792"]
    private(set) var imageGenerationSources = ["Stable Diffusion", "dall-e-3"]
    
    // MARK: - Image parameters
    
    @Published var imageStyle: String = ""
    //    @Published var imageSize: String?
    //    @Published var imageGenerationSource: String?
    
    // MARK: - Init
    
    init(appSession: AppSession,
         generationModel: AIGenerationModel,
         storedImagesManager: StoredImagesDataManager,
         photoAlbumService: PhotoAlbumService) {
        self.appSession = appSession
        self.generationModel = generationModel
        self.storedImagesManager = storedImagesManager
        self.photoAlbumService = photoAlbumService
    }
    
    // MARK: - Requests
    
    func createImage(with prompt: String) async {
        await MainActor.run {
            error = nil
            imageUrl = nil
            imageData = nil
            showLoading.toggle()
            appSession?.isLoadingNetworkData = true
        }
        
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
//
//        await MainActor.run(body: {
//            imageUrl = URL(string: "https://www.atlasandboots.com/wp-content/uploads/2019/05/ama-dablam2-most-beautiful-mountains-in-the-world.jpg")
//            //            error = .server("Can't generate image. Please try again later or change the prompt")
//        })
        
        do {
            let image = try await generationModel.generateImage(prompt: prompt)
            await MainActor.run(body: {
                imageUrl = image.url
                imageData = image.data
            })
        } catch {
            await MainActor.run {
                self.error = .server(error.localizedDescription)
            }
        }
        
        await MainActor.run(body: {
            showLoading.toggle()
            appSession?.isLoadingNetworkData = false
        })
    }
    
    @MainActor
    func cleanImage() {
        imageUrl = nil
        imageData = nil
    }
}
