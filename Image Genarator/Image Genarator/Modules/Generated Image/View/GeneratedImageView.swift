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
                    AsyncImage(url: viewModel.imageUrl) { phase in
                        switch phase {
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        
                        case .failure(let error):
                            Text(error.localizedDescription)
                            
                        case .empty:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.textMain)
                                .animation(.easeInOut(duration: 0.1), value: 1)
                            
                        default:
                            EmptyView()
                        }
                    }
                    .padding()
                    
                    HStack(alignment: .center) {
                        MainButton(enabled: .constant(true), foregroundColor: .buttonTitle2, backgroundColor: .button2, title: "Save") {
                            viewModel.saveImageToDB()
                            dismiss()
                        }

                        MainButton(enabled: .constant(true), foregroundColor: .buttonTitle2, backgroundColor: .button2, title: "Share") {
                            // Share image
                        }
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
