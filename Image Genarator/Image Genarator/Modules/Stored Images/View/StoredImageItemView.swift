//
//  StoredImageItemView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.06.2024.
//

import SwiftUI

struct StoredImageItemView: View {
    
    let timestamp: Date
    let prompt: String
    let imageUrl: URL
    
    var body: some View {
        ZStack {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                    
                case .success(let image):
                    VStack {
                        ZStack(alignment: .bottomTrailing) {
                            image
                                .resizable()
                                .scaledToFit()
                            
                            Text(DateFormatter.appDateFormatter().string(from: timestamp))
                                .foregroundColor(.white)
                                .padding(7)
                                .background(Color.black.opacity(0.66))
                                .padding(5)
                        }
                        
                        VStack {
                            Text(prompt)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                
                
                case .failure(let error):
                    Text(error.localizedDescription)
                    
                case .empty:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.textMain)
                        .animation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: 0.5)
                    
                default:
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

struct StoredImageItemView_Previews: PreviewProvider {
    static var previews: some View {
        StoredImageItemView(
            timestamp: Date(),
            prompt: "Some generated image",
            imageUrl: URL(string: "https://www.atlasandboots.com/wp-content/uploads/2019/05/ama-dablam2-most-beautiful-mountains-in-the-world.jpg")!
        )
    }
}
