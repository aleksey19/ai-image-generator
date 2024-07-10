//
//  StoredImageItemViewModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 07.07.2024.
//

import Foundation
import UIKit.UIImage
import SwiftUI

final class StoredImageItemViewModel: ObservableObject {
        
    let timestamp: Date
    let prompt: String
    
    init(timestamp: Date,
         prompt: String) {
        self.timestamp = timestamp
        self.prompt = prompt
    }
}
