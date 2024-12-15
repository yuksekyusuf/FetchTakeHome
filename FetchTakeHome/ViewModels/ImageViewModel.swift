//
//  ImageViewModel.swift
//  FetchTakeHome
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//


import SwiftUI
import UIKit


class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    let cacheService: CacheServicing
    
    init(cacheService: CacheServicing) {
        self.cacheService = cacheService
    }
    
    @MainActor func loadImage(urlString: String?) async {
        guard let url = urlString else { return }
        
        if let cachedImage = await cacheService.fetchImage(key: url) {
            self.image = cachedImage
        } else {
            if let downloadedImage = await fetchImageFromURL(url) {
                await cacheService.saveImage(key: url, image: downloadedImage)
                self.image = downloadedImage
            }
        }
    }
    
    private func fetchImageFromURL(_ urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }
            return UIImage(data: data)
        } catch {
            print("Failed to fetch image from URL: \(error)")
            return nil
        }
    }
    
}
