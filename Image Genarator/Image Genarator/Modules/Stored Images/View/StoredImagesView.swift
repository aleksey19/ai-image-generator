//
//  StoredImagesView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.06.2024.
//

import SwiftUI

struct StoredImagesView: View {
    
    @FetchRequest(sortDescriptors: []) private var images: FetchedResults<StoredImage>
    
    var body: some View {
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
        }
    }
}

struct StoredImagesView_Previews: PreviewProvider {
    static var previews: some View {
        StoredImagesView()
    }
}
