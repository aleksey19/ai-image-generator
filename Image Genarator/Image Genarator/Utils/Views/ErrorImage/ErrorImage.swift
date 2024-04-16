//
//  ErrorImage.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 11.04.2024.
//

import SwiftUI

struct ErrorImage: View {
    
    let systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundColor(.white)
            .frame(width: 25, height: 25)
            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background {
                RoundedRectangle(cornerRadius: 10).fill(Color.red)
            }
    }
}

struct ErrorImage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorImage(systemImageName: "xmark.circle.fill")
    }
}
