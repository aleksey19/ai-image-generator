//
//  PersistentContainerProtocol.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.06.2024.
//

import Foundation
import CoreData

// TODO: - Protocol for future tests

protocol PersistentContainerProtocol: AnyObject {
    var isInMemory: Bool { get }
    
    func loadPersistentStores(completionHandler block: @escaping (NSPersistentStoreDescription, Error?) -> Void)
}

extension NSPersistentContainer: PersistentContainerProtocol {
    var isInMemory: Bool {
        false
    }
}
