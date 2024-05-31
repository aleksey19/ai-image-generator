//
//  StringOptional+NotEmpty.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 29.05.2024.
//

import Foundation

extension Optional<String> {
    /// Returns `true` if string not nil and length is greater than zero
    var notEmpty: Bool {
        switch self {
        case .none: return false
        case .some(let wrapped): return !wrapped.isEmpty
        }
    }
}
