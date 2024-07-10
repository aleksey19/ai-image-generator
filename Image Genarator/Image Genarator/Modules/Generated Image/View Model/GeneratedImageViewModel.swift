//
//  GeneratedImageViewModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 17.04.2024.
//

import Foundation
import CoreData

final class GeneratedImageViewModel: ObservableObject {
    
    @Published private(set) var imageUrl: URL?
    @Published private(set) var imageData: Data?
    @Published private(set) var prompt: String
    
    private(set) unowned var storedImagesManager: StoredImagesDataManager
    private unowned var photoAlbumService: PhotoAlbumService
    
    init(imageUrl: URL?,
         imageData: Data?,
         prompt: String,
         storedImagesManager: StoredImagesDataManager,
         photoAlbumService: PhotoAlbumService) {
        self.imageUrl = imageUrl
        self.imageData = imageData
        self.prompt = prompt
        self.storedImagesManager = storedImagesManager
        self.photoAlbumService = photoAlbumService
    }
    
    // MARK: - Save image
    
    func saveImageToDB() {
        storedImagesManager.saveToDBImage(with: imageUrl, base64Data: imageData, prompt: prompt)
    }
    
    func saveToPhotos() {
        if let data = imageData {
            photoAlbumService.addImageToPhotoAlbum(with: data)
        }
    }
}
