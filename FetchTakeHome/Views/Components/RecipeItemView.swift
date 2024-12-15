//
//  RecipeItemView.swift
//  FetchTakeHome
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//


import SwiftUI

struct RecipeItemView: View {
    let recipe: Recipe
    let cacheService: CacheServicing
    var body: some View {
        VStack {
            ImageView(urlString: recipe.photoURLSmall, cacheService: cacheService)
                .padding(.top, 20)
            Spacer()
            Text(recipe.name)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
                .padding(.horizontal, 5)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            Text(recipe.cuisine)
                .font(.caption.bold())
                .foregroundColor(.brown)
            Spacer()
        }
        .frame(width: 160, height: 200)
        .background(Color.indigo.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    RecipeItemView(recipe: Recipe.sample, cacheService: CacheService())
}
