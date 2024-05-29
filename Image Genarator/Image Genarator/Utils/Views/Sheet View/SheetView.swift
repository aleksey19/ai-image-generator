//
//  SheetView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 17.04.2024.
//

import SwiftUI

struct SheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let selectedOption: String?
    let options: [String]
    let selectAction: (String) -> Void
    
    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
            
            List {
                ForEach(options, id: \.self) { option in
                    SheetViewRow(selectedOption: selectedOption, option: option) {
                        selectAction($0)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(
            selectedOption: "option 1",
            options: ["option 1", "option 2"],
            selectAction: { _ in }
        )
    }
}
