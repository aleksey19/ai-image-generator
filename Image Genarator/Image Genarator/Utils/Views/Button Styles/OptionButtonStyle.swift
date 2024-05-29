//
//  CTAButtonStyle.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 16.04.2024.
//

import SwiftUI

struct OptionButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let enabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration
            .label
            .padding()
            .foregroundColor(enabled || configuration.isPressed ? foregroundColor : foregroundColor.opacity(0.5))
            .background(enabled || configuration.isPressed ? backgroundColor : backgroundColor.opacity(0.5))
            .cornerRadius(15)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(foregroundColor, lineWidth: 0)
            }
            .padding([.top, .bottom], 10)
            .fontWeight(.semibold)
    }
}
