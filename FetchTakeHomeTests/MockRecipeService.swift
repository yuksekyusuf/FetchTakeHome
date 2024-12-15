//
//  MockRecipeService.swift
//  FetchTakeHome
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//

@testable import FetchTakeHome

class MockRecipeService: RecipeServicing {
    var shouldThrowError: Bool = false
    var mockRecipes: [Recipe] = []
    func getRecipes(from url: String) async throws -> [Recipe] {
        if shouldThrowError {
            throw RecipeError.invalidResponse
        }
        return mockRecipes
    }
}
