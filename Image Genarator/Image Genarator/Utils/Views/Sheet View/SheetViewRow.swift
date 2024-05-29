//
//  SheetViewRow.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 17.04.2024.
//

import SwiftUI

struct SheetViewRow: View {
    
    let selectedOption: String?
    let option: String
    let selectAction: (String) -> Void
    
    var body: some View {
        HStack {
            Text(option)
            
            Spacer()
            
            if selectedOption == option {
                Image(systemName: "checkmark")
            }
        }
        .onTapGesture {
            selectAction(option)
        }
    }
}

struct SheetViewRow_Previews: PreviewProvider {
    static var previews: some View {
        SheetViewRow(
            selectedOption: "option",
            option: "option",
            selectAction: { _ in }
        )
    }
}
