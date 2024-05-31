//
//  URLSessionProtocol.swift
//  Image Genarator
//
//  Created by Aleksey Bidnyk on 29.05.2024.
//

import Foundation

protocol URLSessionProtocol: AnyObject {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
    func invalidateAndCancel()
}

extension URLSession: URLSessionProtocol { }
