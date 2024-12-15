//
//  Dependencies.swift
//  FetchTakeHome
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//


import Foundation

class Dependencies {
    let recipeService: RecipeServicing
    let cacheService: CacheServicing
    
    init(recipeService: RecipeServicing, cacheService: CacheServicing) {
        self.recipeService = recipeService
        self.cacheService = cacheService
    }
}