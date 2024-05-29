//
//  GeneratedImageViewModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 17.04.2024.
//

import Foundation

class GeneratedImageViewModel: ObservableObject {

    @Published private(set) var imageUrl: URL
    
    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }
}
