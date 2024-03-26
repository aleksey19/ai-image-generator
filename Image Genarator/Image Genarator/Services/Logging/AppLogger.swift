//
//  AppLogger.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

final class AppLogger {
    
    static let shared = AppLogger()
}

extension AppLogger: Logable {
    
    func log(error: Error) {
        debugPrint("🚫 Error: \(error)")
    }
    
    func log(info: String) {
        debugPrint("🗒 Info: \(info)")
    }
    
    func log(warning: String) {
        debugPrint("⚠️ Info: \(warning)")
    }
}
