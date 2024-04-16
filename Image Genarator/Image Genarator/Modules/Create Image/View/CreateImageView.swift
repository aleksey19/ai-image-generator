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
    @State private var presentAlert: Bool = false
    
    @State var enableCreateImage: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.bg.edgesIgnoringSafeArea([.all])
            
            VStack(alignment: .center) {
                
                if viewModel.imageUrl != nil {
                    AsyncImage(url: viewModel.imageUrl) { phase in
                        switch phase {
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                            
                        default:
                            EmptyView()
                        }
                    }
                    .padding()
                }
                
                TextField("Enter image prompt", text: $prompt.animation(), axis: .vertical)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5, reservesSpace: true)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.textMain, lineWidth: 2)
                    }
                    .padding(10)
                
                MainButton(enabled: $prompt.map { $0.count > 2 }, foregroundColor: .buttonTitle, backgroundColor: .button, title: "Create Image") {
                    dismissKeyboard()
                    Task {
                        await createImage()
                    }
                }
                
                Button("Clear image") {
                    cleanImage()
                }
                .tint(Color.red)
                .opacity(viewModel.imageUrl != nil ? 1 : 0)
            }
            .padding()
            .blur(radius: (viewModel.showLoading == true || presentAlert == true) ? 3 : 0)
            .animation(.default, value: presentAlert)
            
            if viewModel.showLoading {
                LoadingView()
                    .animation(.default, value: viewModel.showLoading)
            }
            
            if let error = viewModel.error,
               presentAlert == true {
                AlertView(title: "Error", message: error.localizedDescription, imageName: error.imageName) {
                    presentAlert = false
                }
                .animation(.default, value: presentAlert)
            }
        }
        .onTapGesture {
            dismissKeyboard()
        }
        .onChange(of: viewModel.error) { newValue in
            presentAlert = newValue != nil
        }
    }
    
    // MARK: - Funcs
    
    private func createImage() async {
        await viewModel.createImage(with: prompt)
    }
    
    private func cleanImage() {
        viewModel.cleanImage()
    }
}
