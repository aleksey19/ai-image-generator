//
//  GeneratedImageViewModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 17.04.2024.
//

import Foundation
import CoreData

final class GeneratedImageViewModel: ObservableObject {

    private weak var persistenceController: PersistenceController?
    
    @Published private(set) var imageUrl: URL
    @Published private(set) var prompt: String
    
    init(persistenceController: PersistenceController,
         imageUrl: URL,
         prompt: String) {
        self.persistenceController = persistenceController
        self.imageUrl = imageUrl
        self.prompt = prompt
    }
    
    // MARK: - Save
    
    func saveToDB() {
        if let context = persistenceController?.container.viewContext {
            saveImage(context: context,
                      uuid: UUID(),
                      timestamp: Date(),
                      prompt: prompt,
                      imageUrl: imageUrl)
        }
    }
    
    private func saveImage(context: NSManagedObjectContext,
                           uuid: UUID,
                           timestamp: Date,
                           prompt: String,
                           imageUrl: URL) {
        var model = StoredImage(context: context)
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
