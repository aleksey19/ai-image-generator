//
//  Image_GenaratorApp.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 19.03.2024.
//

import SwiftUI

@main
struct Image_GenaratorApp: App {
//    let persistenceController = PersistenceController.shared
    private lazy var appSession = AppSession()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: TestViewModel(
                    httpClient: OpenAIHTTPClient(
                        host: APIUrls.openAIApiURL,
                        apiVersion: "v1",
                        notAuthorizedHandler: nil,
                        serverErrorHandler: nil,
                        setAuthorizationTokenHandler: nil,
                        refreshAuthorizationTokenHandler: nil
                    )
                )
            )
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
