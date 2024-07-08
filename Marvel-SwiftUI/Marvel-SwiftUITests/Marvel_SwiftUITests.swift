//
//  Marvel_SwiftUITests.swift
//  Marvel-SwiftUITests
//
//  Created by Guilherme Silva on 23/01/24.
//

import XCTest
@testable import Marvel_SwiftUI

final class Marvel_SwiftUITests: XCTestCase {
    
    var viewModel: CharactersListViewModel!
    var mockApi: MockApiClient!

    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        viewModel = CharactersListViewModel()
        mockApi = MockApiClient()
        viewModel.service = CharacterService(apiClient: mockApi)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func testExample() async throws {
        await viewModel.fetchCharacters()
        XCTAssertTrue(!viewModel.characters.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
