//
//  Binding+Map.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 16.04.2024.
//

import SwiftUI

extension Binding {
    
    func map<NewValue>(_ transform: @escaping (Value) -> NewValue) -> Binding<NewValue> {
        Binding<NewValue>(get: { transform(wrappedValue) }, set: { _ in })
    }
}
