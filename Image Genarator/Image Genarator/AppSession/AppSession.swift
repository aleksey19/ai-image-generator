//
//  AppSession.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 19.03.2024.
//

import Foundation
import CoreData

final class AppSession: ObservableObject {
    
    lazy private(set) var openAIHTTPClient: HTTPClient = OpenAIHTTPClient(
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
    
    lazy private(set) var stableDiffusionHTTPClient: HTTPClient = OpenAIHTTPClient(
        session: URLSession.shared,
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
    
    private var container: NSPersistentContainer =  {
        let description = NSPersistentStoreDescription()
        description.type = NSSQLiteStoreType
        let container = NSPersistentContainer(name: "Image_Genarator")
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Error while loading persistent store: \(error.localizedDescription)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    lazy private(set) var imagesStorageDataManager = StoredImagesDataManager(persistentContainer: container)
    
    @Published var connectionIsReachable: Bool = true
    @Published var isLoadingNetworkData: Bool = false
}
