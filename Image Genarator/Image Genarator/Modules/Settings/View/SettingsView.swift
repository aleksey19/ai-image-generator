//
//  SettingsView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 07.06.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        ZStack {
            List {
                HStack {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                            .foregroundColor(.textMain)
                    }
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .background(Color.bg)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
