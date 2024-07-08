//
//  CharacterDetailViewModelTest.swift
//  Marvel-SwiftUITests
//
//  Created by Guilherme Silva on 08/07/24.
//

import XCTest
@testable import Marvel_SwiftUI

final class CharacterDetailViewModelTest: XCTestCase {

    var viewModel: CharacterDetailViewModel!
    var mockApi: MockApiClient!

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        viewModel = CharacterDetailViewModel(characterId: 1)
        mockApi = MockApiClient()
        viewModel.service = CharacterService(apiClient: mockApi)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        viewModel = nil
        mockApi = nil
    }

    @MainActor func testFetchCharacterDetailSuccess() async throws {
        await viewModel.fetchCharacterDetail()
        XCTAssertNotNil(viewModel.character)
    }
    
    @MainActor func testFetchCharacterComicsSuccess() async throws {
        await viewModel.fetchCharacterComics()
        XCTAssertTrue(!viewModel.comics.isEmpty)
    }
}
