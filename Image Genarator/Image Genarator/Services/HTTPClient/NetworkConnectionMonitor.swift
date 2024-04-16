//
//  NetworkConnectionMonitor.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 15.04.2024.
//

import Foundation
import Network

final class NetworkConnectionMonitor {
    
    static let shared = NetworkConnectionMonitor()
    
    private let pathMonitor = NWPathMonitor()
    
    
    func startTrackingConnectionState(with handler: ((NWPath.Status) -> Void)?) {
        
        pathMonitor.pathUpdateHandler = {
            handler?($0.status)
        }
        
        let queue = DispatchQueue(label: "NWPathMonitor", qos: .default)
        
        pathMonitor.start(queue: queue)
    }
    
    func stopTrackingConnectionState() {
        pathMonitor.cancel()
    }
}
