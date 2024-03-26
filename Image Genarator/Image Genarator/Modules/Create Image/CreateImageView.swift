//
//  CreateImageView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import Foundation
import SwiftUI

struct CreateImageView: View {
    
    var viewModel: TestViewModel
    
    @State private var prompt: String = ""
    
    
    var body: some View {
        VStack(alignment: .center) {
            TextField("Enter image prompt", text: $prompt)
                .border(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Create Image") {
                Task {
                    await createImage()
                }
            }
            .disabled(prompt.count < 3)
        }
        .padding()
    }
    
    private func createImage() async {
        try? await viewModel.createImage(with: prompt)
    }
}
