//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//

import SwiftUI

@main
struct FetchTakeHomeApp: App {
    let dependencies = Dependencies(
        recipeService: RecipeService(),
        cacheService: CacheService())
    var body: some Scene {
        WindowGroup {
            HomeView(dependencies: dependencies)
        }
    }
}
