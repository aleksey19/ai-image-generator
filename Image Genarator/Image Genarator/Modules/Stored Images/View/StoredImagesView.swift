//
//  StoredImagesView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 10.06.2024.
//

import SwiftUI

struct StoredImagesView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp, order: .reverse)])
    private var images: FetchedResults<StoredImage>
    
    var body: some View {
        ZStack {
            Color.bg.edgesIgnoringSafeArea([.all])
            
            ScrollView {
                LazyVGrid(columns: [_](repeating: GridItem(), count: 1)) {
                    ForEach(images, id: \.self) { image in
                        NavigationLink {
                            Text(image.prompt ?? "")
                        } label: {
                            if let timestamp = image.timestamp,
                               let prompt = image.prompt,
                               let imageData = image.imageData {
                                StoredImageItemView(imageData: imageData, timestamp: timestamp, prompt: prompt)
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
}

//struct StoredImagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoredImagesView()
//    }
//}
