//
//  ContentView.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 25.03.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject private var appSession: AppSession
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp, order: .reverse)])
    private var images: FetchedResults<StoredImage>
    
    var blurContent: Bool {
        appSession.isLoadingNetworkData
    }
    
    var body: some View {
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
                    viewModel: .init(
                        appSession: appSession,
                        generationModel: OpenAIGenerationModel(httpClient: appSession.openAIHTTPClient),
                        storedImagesManager: appSession.imagesStorageDataManager,
                        photoAlbumService: appSession.photoAlbumService
                    )
                )
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environmentObject(appSession)
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
