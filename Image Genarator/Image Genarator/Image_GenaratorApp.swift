//
//  Image_GenaratorApp.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 19.03.2024.
//

import SwiftUI

@main
struct Image_GenaratorApp: App {
    
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
    
    
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                Color.bg.ignoresSafeArea(.all)
                
                ContentView()
                    .environment(\.managedObjectContext, appSession.imagesStorageDataManager.viewContext!)
                    .environmentObject(appSession)
            }
        }
    }
}
