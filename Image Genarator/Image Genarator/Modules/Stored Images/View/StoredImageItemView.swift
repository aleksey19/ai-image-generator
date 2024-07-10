//
//  StoredImageItemView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.06.2024.
//

import SwiftUI

struct StoredImageItemView: View {        
    
    private(set) var imageData: Data
    private(set) var timestamp: Date
    private(set) var prompt: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if let image = UIImage(data: imageData)! {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }

                HStack {
                    Text("\(imageData.count / 1024)KB")
                        .foregroundColor(.white)
                    Text("|").foregroundColor(.white)
                    Text(DateFormatter.appDateFormatter().string(from: timestamp))
                        .foregroundColor(.white)
                }
                .padding(7)
                .background(Color.black.opacity(0.66))
                .padding(5)
            }

            VStack {
                Text(prompt)
                    .foregroundColor(.textMain)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct StoredImageItemView_Previews: PreviewProvider {
    static var previews: some View {
        StoredImageItemView(
            imageData: Data(capacity: 0),
            timestamp: Date(),
            prompt: "prompt"
        )
    }
}
