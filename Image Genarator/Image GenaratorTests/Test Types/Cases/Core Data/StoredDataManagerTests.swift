//
//  StoredDataManagerTests.swift
//  Image GenaratorTests
//
//  Created by Aleksey Bidnyk on 13.06.2024.
//

import XCTest
import CoreData
@testable import Image_Genarator

final class StoredDataManagerTests: XCTestCase {
    
    private var mockPersistentContainer: MockPersistentContainer!
    private var sut: StoredImagesDataManager!
    private var context: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockPersistentContainer = MockPersistentContainer()
        sut = StoredImagesDataManager(persistentContainer: mockPersistentContainer)
        context = sut.context
    }

    override func tearDownWithError() throws {
//        mockPersistentContainer = nil
        sut = nil
        context = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Given
    
    private func givenSaveImage() {
        let givenUrl = URL(string: "https://www.atlasandboots.com/wp-content/uploads/2019/05/ama-dablam2-most-beautiful-mountains-in-the-world.jpg")
        let givenPrompt = "Some prompt"
        sut.saveToDBImage(with: givenUrl, prompt: givenPrompt)
    }
    
    private func givenFetchItem(with prompt: String) throws -> StoredImage? {
        let fetchRequest = StoredImage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "prompt == %@", prompt)
        let items = try context.fetch(fetchRequest)
        return items.first
    }

    // MARK: - Tests
    
    func test_storedImagesDataManager_initializedWithCorrectPersistentContainer() {
        XCTAssertEqual(mockPersistentContainer, sut.persistentContainer)
    }
    
    func test_storedImagesDataManager_initializedPersistentContainer_withInMemoryType() {
        XCTAssertEqual(NSInMemoryStoreType, sut.persistentContainer?.persistentStoreDescriptions.first?.type)
    }
    
    func test_storedImagesDataManager_savesImage() throws {
        // given
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        givenSaveImage()
        
        // then
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save didn't occur")
        }
    }
    
    func test_storedImagesDataManager_fatchesImages() throws {
        givenSaveImage()
        let givenPrompt = "Some prompt"
        let givenItem = try givenFetchItem(with: givenPrompt)
        
        XCTAssertEqual(givenPrompt, givenItem?.prompt)
    }
    
    func test_storedImagesDataManager_deletesImage() throws {
        // given
        givenSaveImage()
        let givenPrompt = "Some prompt"
        let givenItem = try givenFetchItem(with: givenPrompt)
        
        // when
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        sut.deleteImage(givenItem!)
        
        // then
        waitForExpectations(timeout: 2.0) { [weak self] error in
            XCTAssertNil(error, "Save didn't occur")
            XCTAssertNil(try? self?.givenFetchItem(with: givenPrompt))
        }
    }
    
    func test_storedImagesDataManager_deletesImage_byUUID() throws {
        // given
        givenSaveImage()
        let givenPrompt = "Some prompt"
        let givenItem = try givenFetchItem(with: givenPrompt)
        
        // when
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        sut.deleteImageByUUID(with: givenItem!.uuid)
        
        // then
        waitForExpectations(timeout: 2.0) { [weak self] error in
            XCTAssertNil(error, "Save didn't occur")
            XCTAssertNil(try? self?.givenFetchItem(with: givenPrompt))
        }
    }
    
    func test_storedImagesDataManager_editsImage() throws {
        // given
        givenSaveImage()
        let givenPrompt = "Some prompt"
        let givenItem = try givenFetchItem(with: givenPrompt)
        let editedPrompt = "Edited prompt"
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        
        // when
        givenItem?.prompt = editedPrompt
        try context.save()
        
        // then
        waitForExpectations(timeout: 2.0) { [weak self] error in
            XCTAssertNil(error, "Save didn't occur")
            let editedImage = try? self?.givenFetchItem(with: editedPrompt)
            XCTAssertNotNil(editedImage)
            XCTAssertEqual(editedPrompt, editedImage?.prompt)
        }
    }
}
