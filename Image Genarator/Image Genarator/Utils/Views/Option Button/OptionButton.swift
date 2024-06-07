//
//  OptionButton.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 17.04.2024.
//

import SwiftUI

struct OptionButton: View {
    
    @Binding var enabled: Bool
    
    let foregroundColor: Color
    let backgroundColor: Color
    let title: String
    let isOptional: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if !enabled {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .frame(width: 15, height: 20)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(title).font(.title2)
                        
                        if isOptional {
                            Text("Optional").font(.callout)
                                .opacity(0.75)
                        }
                    }
                    
                    Image(systemName: "chevron.down")
                }
                .opacity(enabled ? 1 : 0.5)
            }
        }
        .buttonStyle(
            CTAButtonStyle(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                enabled: true
            )
        )
        .disabled(!enabled)
    }
}

struct OptionButton_Previews: PreviewProvider {
    static var previews: some View {
        OptionButton(
            enabled: .constant(true),
            foregroundColor: .buttonTitle2,
            backgroundColor: .button2,
            title: "Style",
            isOptional: true,
            action: {}
        )
    }
}
