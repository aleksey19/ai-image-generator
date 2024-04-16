//
//  AlertView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 11.04.2024.
//

import SwiftUI

struct AlertView: View {
    
    let title: String
    let message: String
    let imageName: String
    
    let width: CGFloat = 300
    let height: CGFloat = 200
    let radius: CGFloat = 25
    
    let dismissAction: (() -> Void)?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .opacity(0.1)
                .blur(radius: 10)
            
            VStack {
                ErrorImage(systemImageName: imageName)
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                
                Text(message)
                    .foregroundColor(.white)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
            }
            .onTapGesture {
                dismissAction?()
            }
            .padding()
            .frame(width: width)
            .background {
                RoundedRectangle(cornerRadius: radius)
                    .fill(Color.gray)
            }
        .padding()
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(
            title: "Error",
            message: "Can't genarate image with such prompt ... bla bla bla ...",
            imageName: "gear.badge.xmark",
            dismissAction: nil
        )
    }
}
