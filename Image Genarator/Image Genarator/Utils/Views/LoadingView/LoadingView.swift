//
//  LoadingView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 11.04.2024.
//

import SwiftUI

struct LoadingView: View {
    
    let radius: CGFloat = 25
    let width: CGFloat = 120
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .cornerRadius(radius)
            ProgressView("Loading...")
                .tint(.white)
                .foregroundColor(.white)
        }
        .frame(width: width, height: width)
        .background {
            RoundedRectangle(cornerRadius: radius)
                .stroke()
                .fill(Color.gray)
                .blur(radius: 50)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
