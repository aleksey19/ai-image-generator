//
//  Image_GenaratorApp.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 19.03.2024.
//

import SwiftUI

@main
struct Image_GenaratorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
