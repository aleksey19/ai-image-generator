//
//  StoredImage+CoreDataProperties.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.06.2024.
//
//

import Foundation
import CoreData


extension StoredImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredImage> {
        return NSFetchRequest<StoredImage>(entityName: "StoredImage")
    }

    @NSManaged public var aiGeneratorType: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var imageUrl: URL?
    @NSManaged public var prompt: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var uuid: String
}

extension StoredImage : Identifiable {

}
