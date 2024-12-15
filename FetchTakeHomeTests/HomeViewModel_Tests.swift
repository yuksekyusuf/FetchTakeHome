//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//

import XCTest
import Combine
@testable import FetchTakeHome

@MainActor
final class HomeViewModel_Tests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockService: MockRecipeService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        self.mockService = MockRecipeService()
        self.viewModel = HomeViewModel(recipeService: mockService)
        self.cancellables = []
    }

    override func tearDown() {
        self.viewModel = nil
        self.mockService = nil
        self.cancellables = nil
        super.tearDown()
    }
    func test_HomeViewModel_initialization() {
        // Then
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertEqual(viewModel.filteredRecipes.count, 0)
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.selectedURL, RecipeURL.goodResponse.rawValue)
        XCTAssertEqual(viewModel.currentURL, RecipeURL.goodResponse.rawValue)
    }
    
    func test_HomeViewModel_fetchRecipes_shouldSuccess() async {
        //Given
        mockService.mockRecipes = [
            Recipe(
                id: "1",
                cuisine: "Italian", name: "Pasta",
                photoURLLarge: "https://example.com/pasta_large.jpg",
                photoURLSmall: "https://example.com/pasta_small.jpg",
                sourceURL: "https://example.com/pasta_recipe",
                youtubeURL: "https://youtube.com/pasta_recipe"
            )
        ]
        
        //When
        await viewModel.fetchRecipes()
        
        //Then
        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.recipes.first?.name, "Pasta")
    }
    
    func test_HomeViewModel_setUrl_shouldUpdateRecipesAndCurrentUrl() async {
        //Given
        let newUrl = RecipeURL.custom("https://newurl.com")
        mockService.mockRecipes = [
            Recipe(
                id: "2",
                cuisine: "Japanese", name: "Sushi",
                photoURLLarge: "https://example.com/sushi_large.jpg",
                photoURLSmall: "https://example.com/sushi_small.jpg",
                sourceURL: "https://example.com/sushi_recipe",
                youtubeURL: "https://youtube.com/sushi_recipe"
            )
        ]
        
        //When
        await viewModel.setURL(newUrl)
        
        //Then
        XCTAssertEqual(viewModel.currentURL, newUrl.rawValue)
        XCTAssertEqual(viewModel.selectedURL, newUrl.rawValue)
        XCTAssertEqual(viewModel.recipes.first?.name, "Sushi")
    }
    
    func test_HomeViewModel_isSearching_shouldBeTrue() {
        //When
        viewModel.searchText = "Pizza"
        
        //Then
        XCTAssertTrue(viewModel.isSearching)
    }
    
    func test_HomeViewModel_filteredRecipes_shouldSuccess() {
        let expectation = XCTestExpectation(description: "Search debounce")
        mockService.mockRecipes = [
            Recipe(
                id: "1",
                cuisine: "Italian", name: "Pasta",
                photoURLLarge: "https://example.com/pasta_large.jpg",
                photoURLSmall: "https://example.com/pasta_small.jpg",
                sourceURL: "https://example.com/pasta_recipe",
                youtubeURL: "https://youtube.com/pasta_recipe"
            ),
            Recipe(
                id: "2",
                cuisine: "Japanese", name: "Sushi",
                photoURLLarge: "https://example.com/sushi_large.jpg",
                photoURLSmall: "https://example.com/sushi_small.jpg",
                sourceURL: "https://example.com/sushi_recipe",
                youtubeURL: "https://youtube.com/sushi_recipe"
            )
        ]
        viewModel.recipes = mockService.mockRecipes
        
        // When
        viewModel.searchText = "Sushi"
        
        // Wait for debounce
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // Then
            XCTAssertEqual(self.viewModel.filteredRecipes.count, 1)
            XCTAssertEqual(self.viewModel.filteredRecipes.first?.name, "Sushi")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_HomeViewModel_filteredRecipes_shouldEmptySearchSuccess() {
        //Given
        let expectation = XCTestExpectation(description: "Search debounce")
        viewModel.filteredRecipes = [
            Recipe(
                id: "2",
                cuisine: "Japanese", name: "Sushi",
                photoURLLarge: "https://example.com/sushi_large.jpg",
                photoURLSmall: "https://example.com/sushi_small.jpg",
                sourceURL: "https://example.com/sushi_recipe",
                youtubeURL: "https://youtube.com/sushi_recipe"
            )
        ]
        
        //When
        viewModel.searchText = ""
        
        //Wait for debounce
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // Then
            XCTAssertEqual(self.viewModel.filteredRecipes.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)

    }
}
