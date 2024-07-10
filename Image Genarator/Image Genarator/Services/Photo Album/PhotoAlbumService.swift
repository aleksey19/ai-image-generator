//
//  PhotoAlbumService.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 02.07.2024.
//

import Foundation
import UIKit.UIImage

final class PhotoAlbumService: NSObject {
    
    func addImageToPhotoAlbum(with url: URL) {
        Task(priority: .high) {
            if let image = await downloadImage(with: url) {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedToPhotos), nil)
            }
        }
    }
    
    func addImageToPhotoAlbum(with data: Data) {
        Task(priority: .high) {
            if let image = UIImage(data: data) {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedToPhotos), nil)
            }
        }
    }
    
    private func downloadImage(with url: URL) async -> UIImage? {
        if let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    @objc private func savedToPhotos(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error {
            AppLogger.shared.log(error: error)
        } else {
            print("🏞 Saved to Photos")
        }
    }
}
