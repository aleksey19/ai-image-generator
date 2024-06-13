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
    
    @Published private(set) var items: [StoredImage] = []
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                debugPrint("Failed load persistent store with error: \(error)")
            }
        }
    }
    
    // MARK: - Save image
    
    func saveToDBImage(with url: URL?,
                       prompt: String?) {
        if let context = persistentContainer?.viewContext,
           let prompt = prompt,
           let url = url {
            saveImage(context: context,
                      uuid: UUID(),
                      timestamp: Date(),
                      prompt: prompt,
                      imageUrl: url)
        }
    }
    
    private func saveImage(context: NSManagedObjectContext,
                           uuid: UUID,
                           timestamp: Date,
                           prompt: String,
                           imageUrl: URL) {
        let model = StoredImage(context: context)
        model.uuid = uuid
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
