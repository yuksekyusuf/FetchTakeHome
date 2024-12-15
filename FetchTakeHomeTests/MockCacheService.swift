//
//  MockCacheService.swift
//  FetchTakeHome
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//

@testable import FetchTakeHome
import UIKit

class MockCacheService: CacheServicing {
    var images: [String: UIImage] = [:]
    var fetchImageCalled = false
    var saveImageCalled = false
    
    func fetchImage(key: String) async -> UIImage? {
        fetchImageCalled = true
        return images[key]
    }
    
    func saveImage(key: String, image: UIImage) async {
        saveImageCalled = true
        images[key] = image
    }
}
