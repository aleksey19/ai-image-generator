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
    @StateObject private var appSession = AppSession()
    
    //    init() {
    //        // this is not the same as manipulating the proxy directly
    //        let appearance = UINavigationBarAppearance()
    //
    //        // this overrides everything you have set up earlier.
    //        appearance.configureWithTransparentBackground()
    //
    //        // this only applies to big titles
    //        appearance.largeTitleTextAttributes = [
    //            .font : UIFont.systemFont(ofSize: 20),
    //            NSAttributedString.Key.foregroundColor : UIColor.black
    //        ]
    //        // this only applies to small titles
    //        appearance.titleTextAttributes = [
    //            .font : UIFont.systemFont(ofSize: 20),
    //            NSAttributedString.Key.foregroundColor : UIColor.black
    //        ]
    //
    //        //In the following two lines you make sure that you apply the style for good
    //        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    //        UINavigationBar.appearance().standardAppearance = appearance
    //
    //        // This property is not present on the UINavigationBarAppearance
    //        // object for some reason and you have to leave it til the end
    //        UINavigationBar.appearance().tintColor = UIColor(named: "bg")
    //    }
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.timestamp, order: .reverse)
        ]
    ) var images: FetchedResults<StoredImage>
    
    var blurContent: Bool {
        appSession.isLoadingNetworkData
    }
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                Color.bg.ignoresSafeArea(.all)
                
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
                    
                    TabView {
                        CreateImageView(
                            viewModel: .init(appSession: appSession, httpClient: appSession.openAIClient)
                        )
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                        .environmentObject(appSession)
                        //            ContentView()
                        //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .tabItem {
                            Label("Main", systemImage: "paintbrush.pointed")
                        }
                        
                        if !images.isEmpty {
                            StoredImagesView()
                                .tabItem {
                                    Label("History", systemImage: "photo.on.rectangle.angled")
                                }
                        }
                        
                        SettingsView()
                            .preferredColorScheme(isDarkMode ? .dark : .light)
                            .tabItem {
                                Label("Settings", systemImage: "gearshape")
                            }
                    }
                    .tint(Color.textMain)
                }
                .blur(radius: blurContent ? 3 : 0)
                
                if appSession.isLoadingNetworkData {
                    LoadingView()
                        .animation(.default, value: appSession.isLoadingNetworkData)
                }
            }
        }
    }
}
