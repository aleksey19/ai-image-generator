//
//  ContentView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var appSession: AppSession
    
    private(set) var viewModel: CreateImageViewModel
    
    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
            
            VStack {
                if appSession.connectionIsReachable == false {
                    Label("No internet", systemImage: "wifi.slash")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.size.width)
                        .padding(5)
                        .background(Color.red)
                        .animation(.default, value: appSession.connectionIsReachable)
                        .padding(.top)
                }
                
                Spacer()
                
                CreateImageView(viewModel: viewModel)
                
                Spacer()
            }
            .navigationTitle("Create Image")
        }
    }
}
