//
//  AppSessionTests.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 22.04.2024.
//

import XCTest
@testable import Image_Genarator

final class AppSessionTests: XCTestCase {

    var sut: AppSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AppSession()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Properties
    
    func testAppSession_whenInitialised_nonNilOpenAIClient() {
        XCTAssertNotNil(sut.openAIHTTPClient)
    }
}
