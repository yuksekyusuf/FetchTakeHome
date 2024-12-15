//
//  CacheServicing.swift
//  FetchTakeHome
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//


import Foundation
import UIKit

protocol CacheServicing {
    func fetchImage(key: String) async -> UIImage?
    func saveImage(key: String, image: UIImage) async
}

actor CacheService: CacheServicing {
    private let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 //100 MB
        return cache
    }()
    
    func fetchImage(key: String) async -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func saveImage(key: String, image: UIImage) async {
        let cost = image.jpegData(compressionQuality: 1)?.count ?? 0
        cache.setObject(image, forKey: key as NSString, cost: cost)
    }
}
