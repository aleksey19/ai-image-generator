//
//  AppSession.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 19.03.2024.
//

import Foundation
import CoreData

final class AppSession: ObservableObject {
    
    /// Dall-e http client
    lazy private(set) var openAIHTTPClient: HTTPClient = {
        let session = URLSession(configuration: .default)
        let client = OpenAIHTTPClient(
            session: URLSession.shared,
            host: APIUrls.openAIApiURL,
            apiVersion: "v1",
            notAuthorizedHandler: nil,
            serverErrorHandler: nil,
            setAuthorizationTokenHandler: nil,
            refreshAuthorizationTokenHandler: nil,
            connectionStateChangedHandler: { status in
                DispatchQueue.main.async { [weak self] in
                    self?.connectionIsReachable = status == .satisfied
                }
            }
        )
        return client
    }()
    
    /// Stable diffusion http client
    lazy private(set) var stableDiffusionHTTPClient: HTTPClient = {
        let session = URLSession(configuration: .default)
        let client = OpenAIHTTPClient(
            session: session,
            host: APIUrls.stableDiffusionApiURL,
            apiVersion: "api/v3",
            notAuthorizedHandler: nil,
            serverErrorHandler: nil,
            setAuthorizationTokenHandler: nil,
            refreshAuthorizationTokenHandler: nil,
            connectionStateChangedHandler: { status in
                DispatchQueue.main.async { [weak self] in
                    self?.connectionIsReachable = status == .satisfied
                }
            }
        )
        return client
    }()
    
    /// NSPersistentContainer
    private var container: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: "Image_Genarator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Error while loading persistent store: \(error.localizedDescription)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    /// StoredImagesDataManager
    lazy private(set) var imagesStorageDataManager = StoredImagesDataManager(persistentContainer: container)
    
    /// PhotoAlbumService
    lazy private(set) var photoAlbumService = PhotoAlbumService()
    
    
    @Published var connectionIsReachable: Bool = true
    @Published var isLoadingNetworkData: Bool = false
}
