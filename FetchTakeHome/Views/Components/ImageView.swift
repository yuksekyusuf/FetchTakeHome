//
//  ImageView.swift
//  FetchTakeHome
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//


import SwiftUI


struct ImageView: View {
    let urlString: String?
    let cacheService: CacheServicing
    @StateObject private var imageViewModel: ImageViewModel
    
    init(urlString: String?, cacheService: CacheServicing) {
        _imageViewModel = StateObject(wrappedValue: ImageViewModel(cacheService: cacheService))
        self.cacheService = cacheService
        self.urlString = urlString
    }
    var body: some View {
        ZStack {
            if let image = imageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 120)
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .frame(width: 140, height: 120)
                    .background(.secondary.opacity(0.3))
                    .cornerRadius(8)
            }
        }
        .shadow(radius: 4)
        .onAppear {
            Task(priority: .background) {
                await imageViewModel.loadImage(urlString: urlString)
            }
        }
    }
}

#Preview {
    ImageView(urlString: Recipe.sample.photoURLLarge, cacheService: CacheService())
}
