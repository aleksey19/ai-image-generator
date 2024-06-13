//
//  AppSession.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 19.03.2024.
//

import Foundation
import CoreData

final class AppSession: ObservableObject {
    
    static let shared = AppSession()
    
    lazy private(set) var openAIClient: HTTPClient = OpenAIHTTPClient(
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
    
    private var container: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: "Image_Genarator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Error while loading persistent store: \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    lazy private(set) var imagesStorageDataManager: any StoredDataManager = StoredImagesDataManager(persistentContainer: container)
    
    @Published var connectionIsReachable: Bool = true
}
