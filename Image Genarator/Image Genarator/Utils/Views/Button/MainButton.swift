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
    let image: String?
    let title: String?
    let action: () -> Void
    let stretched: Bool
    
    init(enabled: Binding<Bool>,
         foregroundColor: Color,
         backgroundColor: Color,
         image: String? = nil,
         title: String? = nil,
         stretched: Bool = true,
         action: @escaping () -> Void) {
        self._enabled = enabled
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.image = image
        self.title = title
        self.action = action
        self.stretched = stretched
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: Self.horizontalMargin)
            
            Button(action: action) {
                HStack {
                    if stretched {
                        Spacer()
                    }
                    if let image = image {
                        Image(systemName: image)
                    }
                    if let title = title {
                        Text(title)
                    }
                    if stretched {
                        Spacer()
                    }
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
            image: "square.and.arrow.up",
            title: "Press Me",
            stretched: true,
            action: {}
        )
    }
}
