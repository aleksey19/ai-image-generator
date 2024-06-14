//
//  StoredDataManager.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.06.2024.
//

import Foundation
import CoreData

protocol StoredDataManager: AnyObject {
    associatedtype T
    var context: NSManagedObjectContext { get }
    var persistentContainer: NSPersistentContainer? { get }
    var items: [T] { get }
}
