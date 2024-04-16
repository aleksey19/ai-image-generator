//
//  MainButton.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 16.04.2024.
//

import SwiftUI

struct MainButton: View {
    
    private static let horizontalMargin: CGFloat = 10
    
    @Binding var enabled: Bool
    
    let foregroundColor: Color
    let backgroundColor: Color
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer(minLength: Self.horizontalMargin)
            
            Button(action: action) {
                HStack {
                    Spacer()
                    Text(title)
                    Spacer()
                }
            }
            .buttonStyle(
                CTAButtonStyle(backgroundColor: backgroundColor, foregroundColor: foregroundColor, enabled: enabled)
            )
            .disabled(!enabled)
            
            Spacer(minLength: Self.horizontalMargin)
        }
    }
}

struct CTAButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(
            enabled: .constant(true),
            foregroundColor: .buttonTitle,
            backgroundColor: .button,
            title: "Press Me",
            action: {}
        )
    }
}
