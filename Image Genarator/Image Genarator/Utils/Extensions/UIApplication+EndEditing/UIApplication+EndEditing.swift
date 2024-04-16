//
//  UIApplication+EndEditing.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 16.04.2024.
//

import UIKit

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
