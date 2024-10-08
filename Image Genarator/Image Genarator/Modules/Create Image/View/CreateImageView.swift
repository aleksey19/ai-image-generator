//
//  CreateImageView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation
import SwiftUI

struct CreateImageView: View {
    
    @StateObject var viewModel: CreateImageViewModel
    
    @State private var prompt: String = ""
    
    private var blurContent: Bool {
        presentError || presentImageSheet || presentImageStyleSheet || presentImageSizeSheet || presentImageGeneratorSourceSheet
    }
    
    // MARK: - Alert presenting switchers
    
    @State private var presentError: Bool = false
    @State private var presentImageSheet: Bool = false
    @State private var presentImageStyleSheet: Bool = false
    @State private var presentImageSizeSheet: Bool = false
    @State private var presentImageGeneratorSourceSheet: Bool = false
    
    // MARK: - UI state switchers
    
    @State private var enableCreateImage: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.bg.edgesIgnoringSafeArea([.all])
            
            VStack(alignment: .center) {
                
                ZStack(alignment: .topTrailing) {
                    TextField("Enter image prompt", text: $prompt.animation(), axis: .vertical)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5, reservesSpace: true)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.textMain, lineWidth: 2)
                        }
                        .padding(10)
                    
                    if !prompt.isEmpty {
                        ZStack {
                            Button {
                                prompt = ""
                            } label: {
                                Image(systemName: "xmark.circle")
                            }
                        }
                        .padding(20)
                    }
                }
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], alignment: .leading, spacing: 15) {
                    OptionButton(enabled: .constant(true), foregroundColor: .buttonTitle2, backgroundColor: .button2, title: "Style", isOptional: true) {
//                        presentImageStyleSheet.toggle()
                    }
                    
                    OptionButton(enabled: .constant(true), foregroundColor: .buttonTitle2, backgroundColor: .button2, title: "Resolution", isOptional: true) {
//                        presentImageSizeSheet.toggle()
                    }
                    
                    OptionButton(enabled: .constant(false), foregroundColor: .buttonTitle2, backgroundColor: .button2, title: "AI Model", isOptional: true) {
//                        presentImageGeneratorSourceSheet.toggle()
                    }
                }
                .padding([.leading, .trailing], 10)
                
                MainButton(enabled: $prompt.map { $0.count > 2 }, foregroundColor: .buttonTitle, backgroundColor: .button, image: nil, title: "Create Image") {
                    dismissKeyboard()
                    Task {
                        await createImage()
                    }
                }
            }
            .padding()
            .blur(radius: blurContent ? 3 : 0)
            .animation(.default, value: presentError)
            
            if let error = viewModel.error,
               presentError == true {
                AlertView(title: "Error", message: error.localizedDescription, imageName: error.imageName) {
                    presentError = false
                }
                .animation(.default, value: presentError)
            }
        }
        .onTapGesture {
            dismissKeyboard()
        }
        .onChange(of: viewModel.error) { newValue in
            presentError = newValue != nil
        }
        .onChange(of: viewModel.imageUrl) { newValue in
            presentImageSheet = newValue != nil
        }
        .onChange(of: viewModel.imageData) { newValue in
            presentImageSheet = newValue != nil
        }
        .sheet(isPresented: $presentImageSheet) {
            GeneratedImageView(
                viewModel: GeneratedImageViewModel(
                    imageUrl: viewModel.imageUrl, imageData: viewModel.imageData, prompt: prompt, storedImagesManager: viewModel.storedImagesManager, photoAlbumService: viewModel.photoAlbumService
                )
            )
        }
        .sheet(isPresented: $presentImageStyleSheet) {
            SheetView(selectedOption: viewModel.imageStyle, options: viewModel.imageStyles) {
                viewModel.imageStyle = $0
            }
        }
//        .sheet(isPresented: $presentImageStyleSheet) {
//            SheetView($viewModel.imageStyle, options: viewModel.imageStyles)
//        }
//        .sheet(isPresented: $presentImageSizeSheet) {
//            SheetView($viewModel.imageSize, options: viewModel.imageSizes)
//        }
//        .sheet(isPresented: $presentImageGeneratorSourceSheet) {
//            SheetView($viewModel.imageGenerationSource, options: viewModel.imageGenerationSources)
//        }
    }
    
    // MARK: - Funcs
    
    private func createImage() async {
        await viewModel.createImage(with: prompt)
    }
    
    private func cleanImage() {
        viewModel.cleanImage()
    }
}
