//
//  View+DismissKeyboard.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 16.04.2024.
//

import SwiftUI

extension View {
    
    func dismissKeyboard() {
        UIApplication.shared.endEditing()
    }
}
