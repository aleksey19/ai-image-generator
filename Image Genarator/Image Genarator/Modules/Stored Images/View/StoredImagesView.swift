//
//  StoredImagesView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.06.2024.
//

import SwiftUI

struct StoredImagesView: View {
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.timestamp, order: .reverse)
        ]
    ) var images: FetchedResults<StoredImage>
    
    var body: some View {
        ZStack {
            Color.bg.edgesIgnoringSafeArea([.all])
            
            List {
                ForEach(images, id: \.self) { image in
                    NavigationLink {
                        Text(image.prompt ?? "")
                    } label: {
                        if let timestamp = image.timestamp,
                           let prompt = image.prompt,
                           let imageUrl = image.imageUrl {
                            StoredImageItemView(timestamp: timestamp, prompt: prompt, imageUrl: imageUrl)
                        } else {
                            EmptyView()
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .background(Color.bg)
        }
    }
}

struct StoredImagesView_Previews: PreviewProvider {
    static var previews: some View {
        StoredImagesView()
    }
}
