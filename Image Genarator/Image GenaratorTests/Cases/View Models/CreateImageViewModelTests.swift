//
//  CreateImageViewModelTests.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 22.04.2024.
//

import XCTest
@testable import Image_Genarator

final class CreateImageViewModelTests: XCTestCase {

    var sut: CreateImageViewModel!
    
    override func setUpWithError() throws {
        sut = CreateImageViewModel(httpClient: nil)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Initial state
    
    func testCreateImageViewModel_whenCreated_imageUrlIsNil() async {
        await MainActor.run { XCTAssertNil(sut.imageUrl) }
    }
    
    // MARK: - Clean properties
    
    func testCreateImageViewModel_cleansImageUrl() async {
        // when
        await MainActor.run { sut.cleanImage() }
        // then
        await MainActor.run { XCTAssertNil(sut.imageUrl) }
    }
}
