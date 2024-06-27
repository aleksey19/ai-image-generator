//
//  AIGenerationModel.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.06.2024.
//

import Foundation

protocol AIGenerationModel: AnyObject {
    func generateImage(prompt: String) async throws -> GeneratedImage
}
