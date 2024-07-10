//
//  GeneratedImageView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 17.04.2024.
//

import SwiftUI

struct GeneratedImageView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataManager: StoredImagesDataManager
    
    @StateObject var viewModel: GeneratedImageViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bg.ignoresSafeArea()
                
                VStack {
                    if let data = viewModel.imageData,
                       let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    
                    HStack() {
                        MainButton(enabled: .constant(true), foregroundColor: .buttonTitle2, backgroundColor: .button2, image: "square.and.arrow.down", stretched: false) {
                            /// Save to db and Photos
                            viewModel.saveImageToDB()
                            /// Save to Photos
                            viewModel.saveToPhotos()
                            dismiss()
                        }
                        
//                        MainButton(enabled: .constant(true), foregroundColor: .buttonTitle2, backgroundColor: .button2, image: "photo.on.rectangle.angled", stretched: false) {
//                            /// Open Photos
//                        }
                        
                        MainButton(enabled: .constant(true), foregroundColor: .buttonTitle2, backgroundColor: .button2, image: "square.and.arrow.up", stretched: false) {
                            // Share image
                        }
                        
                        Spacer()
                    }
                    .padding([.leading, .trailing], 10)
                }
            }
            .navigationTitle("Genarated Image")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(.textMain)
                    }
                }
            }
        }
    }
}
