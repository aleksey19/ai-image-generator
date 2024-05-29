//
//  ConfigLoaderTests.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 22.04.2024.
//

import XCTest
@testable import Image_Genarator

final class ConfigLoaderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testConfigLoader_whenConfigNotFound_throws() {
        XCTAssertThrowsError(try ConfigLoader.parseConfig(named: "not-found.plist"))
    }
    
    func testConfigLoader_whenConfigFoundAndDecoded_doesNotThrow() {
        XCTAssertNoThrow(try ConfigLoader.parseConfig())
    }
}
