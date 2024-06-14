//
//  MockPersistentContainer.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 13.06.2024.
//

import Foundation
import CoreData

class MockPersistentContainer: NSPersistentContainer {
    
    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
//        let description = NSPersistentStoreDescription()
//        description.type = NSInMemoryStoreType
//        self.persistentStoreDescriptions = [description]
    }
    
    init() {
        let modelUrl = Bundle.main.url(forResource: "Image_Genarator", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel.init(contentsOf: modelUrl)!
        super.init(name: "Image_Genarator", managedObjectModel: managedObjectModel)
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        self.persistentStoreDescriptions = [description]
        
        self.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                debugPrint("Error while loading persistent store for tests: \(error.localizedDescription)")
            }
        }
    }
}
