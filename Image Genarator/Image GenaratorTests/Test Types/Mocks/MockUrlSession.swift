//
//  MockUrlSession.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 29.05.2024.
//

import Foundation
@testable import Image_Genarator

class MockUrlSession: URLSessionProtocol {
    
    var urlResponse: URLResponse!
    var responseData: Data?
    var error: Error?
    
    func set(urlResponse: URLResponse?, responseData: Data?, error: Error?) {
        self.urlResponse = urlResponse
        self.responseData = responseData
        self.error = error
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        if let data = responseData {
            return (data, urlResponse!)
        }
        return (Data(capacity: 0), urlResponse)
    }
    
    func invalidateAndCancel() {
        
    }
}
