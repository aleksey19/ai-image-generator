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
    var viewContext: NSManagedObjectContext? {
        persistentContainer?.viewContext
    }
    
    @Published private(set) var items: [StoredImage] = []
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.context = persistentContainer.newBackgroundContext()
    }
    
    // MARK: - Save image
    
    func saveToDBImage(with url: URL? = nil,
                       base64Data: Data? = nil,
                       prompt: String) {
        saveImage(uuid: UUID(),
                  timestamp: Date(),
                  prompt: prompt,
                  imageUrl: url,
                  imageData: base64Data)
    }
    
    func deleteImage(_ image: StoredImage) {
        context.delete(image)
        saveContext()
    }
    
    func deleteImageByUUID(with uuid: String) {
        let request = StoredImage.fetchRequest()
        request.predicate = NSPredicate(format: "uuid == %@", uuid)
        
        do {
            if let image = try context.fetch(request).first {
                context.delete(image)
                saveContext()
            }
        } catch {
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    private func saveImage(uuid: UUID,
                           timestamp: Date,
                           prompt: String,
                           imageUrl: URL?,
                           imageData: Data?) {
        let model = StoredImage(context: context)
        model.uuid = uuid.uuidString
        model.timestamp = timestamp
        model.prompt = prompt
        model.imageUrl = imageUrl
        model.imageData = imageData
        
        saveContext()
    }
    
    // MARK: - Save context
    
    private func saveContext() {
        if context.hasChanges == true {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
