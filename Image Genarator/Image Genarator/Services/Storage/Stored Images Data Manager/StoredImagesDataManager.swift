//
//  StoredImagesDataManager.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.06.2024.
//

import Foundation
import CoreData

final class StoredImagesDataManager: StoredDataManager, ObservableObject {
    typealias T = StoredImage
    
    private(set) weak var persistentContainer: NSPersistentContainer?
    private(set) var context: NSManagedObjectContext
    
    @Published private(set) var items: [StoredImage] = []
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.context = persistentContainer.newBackgroundContext()
    }
    
    // MARK: - Save image
    
    func saveToDBImage(with url: URL?,
                       prompt: String?) {
        if let prompt = prompt,
           let url = url {
            saveImage(uuid: UUID(),
                      timestamp: Date(),
                      prompt: prompt,
                      imageUrl: url)
        }
    }
    
    func deleteImage(_ image: StoredImage) {
        context.delete(image)
        do {
            try context.save()
        } catch {
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    func deleteImageByUUID(with uuid: String) {
        let request = StoredImage.fetchRequest()
        request.predicate = NSPredicate(format: "uuid == %@", uuid)
        
        do {
            if let image = try context.fetch(request).first {
                context.delete(image)
                try context.save()
            }
        } catch {
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    private func saveImage(uuid: UUID,
                           timestamp: Date,
                           prompt: String,
                           imageUrl: URL) {
        let model = StoredImage(context: context)
        model.uuid = uuid.uuidString
        model.timestamp = timestamp
        model.prompt = prompt
        model.imageUrl = imageUrl
        
        do {
            try context.save()
        } catch {
            debugPrint("\(error.localizedDescription)")
        }
    }
}
