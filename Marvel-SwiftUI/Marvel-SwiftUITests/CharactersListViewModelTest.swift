//
//  CharactersListViewModelTest.swift
//  Marvel-SwiftUITests
//
//  Created by Guilherme Silva on 08/07/24.
//

import XCTest
@testable import Marvel_SwiftUI

final class CharactersListViewModelTest: XCTestCase {

    var viewModel: CharactersListViewModel!
    var mockApi: MockApiClient!

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        viewModel = CharactersListViewModel()
        mockApi = MockApiClient()
        viewModel.service = CharacterService(apiClient: mockApi)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        viewModel = nil
        mockApi = nil
    }

    @MainActor func testFetchCharactersListSuccess() async throws {
        await viewModel.fetchCharacters()
        XCTAssertTrue(!viewModel.characters.isEmpty)
    }
}
