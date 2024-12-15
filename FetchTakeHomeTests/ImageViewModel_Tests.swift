//
//  ImageViewModel_Tests.swift
//  FetchTakeHomeTests
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//

import XCTest
import UIKit
@testable import FetchTakeHome


@MainActor
final class ImageViewModel_Tests: XCTestCase {
    var viewModel: ImageViewModel!
    var mockCacheService: MockCacheService!

    override func setUp() {
        super.setUp()
        mockCacheService = MockCacheService()
        viewModel = ImageViewModel(cacheService: mockCacheService)
    }

    override func tearDown() {
        viewModel = nil
        mockCacheService = nil
        super.tearDown()
    }

    func test_ImageViewModel_loadImage_shouldReturnImageFromCache() async {
        //Given
        let urlString = "testImageKey"
        let cachedImage = UIImage(systemName: "star")!
        mockCacheService.images[urlString] = cachedImage
        
        //When
        await viewModel.loadImage(urlString: urlString)
        
        //Then
        XCTAssertEqual(viewModel.image?.pngData(), cachedImage.pngData())
        XCTAssertTrue(mockCacheService.fetchImageCalled)
        XCTAssertFalse(mockCacheService.saveImageCalled)
    }
}
