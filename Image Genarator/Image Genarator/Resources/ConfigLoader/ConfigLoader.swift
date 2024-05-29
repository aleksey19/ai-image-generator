//
//  Settings.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 20.03.2024.
//

import Foundation

final class ConfigLoader {
    static let configName = "Config.plist"
    
    static func parseConfig(named fileName: String = configName) throws -> Configuration {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil),
              let fileData = FileManager.default.contents(atPath: filePath) else {
            throw AppError.develop("🚫 Configuration file \(fileName) can't be found")
        }
        
        let config = try PropertyListDecoder().decode(Configuration.self, from: fileData)
        return config
    }
}

struct Configuration: Decodable {
    let cacheImages: Bool
}
