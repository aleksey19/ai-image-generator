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
}
