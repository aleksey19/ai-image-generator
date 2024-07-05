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
        NavigationStack {
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
            .toolbar {
                ToolbarItem {
                    Button {
                        /// Show pop up with clear db dialog
                    } label: {
                        Image(systemName: "trash")
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
