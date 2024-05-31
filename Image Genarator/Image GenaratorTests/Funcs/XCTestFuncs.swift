//
//  XCTestFuncs.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 29.05.2024.
//

import XCTest

public func XCTAssertThrowsError_Async<T>(_ expression: @autoclosure () async throws -> T) async {
    do {
        _ = try await expression()
        XCTFail("No error thrown")
    } catch {
        // Pass
    }
}
