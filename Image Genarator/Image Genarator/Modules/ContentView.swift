//
//  ContentView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    private(set) var viewModel: TestViewModel
    
    var body: some View {
        NavigationView {
            CreateImageView(viewModel: viewModel)
        }
    }
}
