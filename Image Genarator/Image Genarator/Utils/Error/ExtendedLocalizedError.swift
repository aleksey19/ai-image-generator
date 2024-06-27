//
//  ExtendedLocalizedError.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation

protocol ExtendedLocalizedError: LocalizedError {
    var imageName: String { get }
}

enum AppError {
    case develop(String)
    case server(String)
    case navigation(String)
    case decoding(String)
}

extension AppError: ExtendedLocalizedError {
    
    var imageName: String {
        switch self {
            
        case .develop(_):
            return "gear.badge.xmark"
        
        case .server(_):
            return "externaldrive.fill.badge.xmark"
            
        case .navigation(_):
            return "rectangle.badge.xmark.fill"
        }
    }
    
    var errorDescription: String? {
        switch self {
            
        case .develop(let e):
            return e
            
        case .server(let e):
            return e
            
        case .navigation(let e):
            return e
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
            
        case .develop(_):
            return "Develop error. Ensure that your code is correct"
        
        case .server(_):
            return "Try again later"
            
        case .navigation(_):
            return "Scenes navigation error. Ensure that routing works correctly"
        }
    }
}

extension AppError: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}
