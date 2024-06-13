//
//  GeneratedImageViewModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 17.04.2024.
//

import Foundation
import CoreData

final class GeneratedImageViewModel: ObservableObject {
    
    @Published private(set) var imageUrl: URL
    @Published private(set) var prompt: String
    
    init(imageUrl: URL,
         prompt: String) {
        self.imageUrl = imageUrl
        self.prompt = prompt
    }
    
    
}
