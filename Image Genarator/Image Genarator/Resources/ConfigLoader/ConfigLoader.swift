//
//  Settings.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 20.03.2024.
//

import Foundation

final class ConfigLoader {
    static let configName = "Config.plist"
    
    static func parseConfig(named fileName: String = configName) -> Configuration {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil),
            let fileData = FileManager.default.contents(atPath: filePath) else {
                fatalError("🚫 Configuration file \(fileName) can't be loaded!")
        }
        
        do {
            let config = try PropertyListDecoder().decode(Configuration.self, from: fileData)
            return config
        } catch {
            fatalError("🚫 Configuration file \(fileName) can't be decoded: \(error)!")
        }
    }
}

struct Configuration: Decodable {
    let cacheImages: Bool
}
