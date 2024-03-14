// ImageLoadProxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class ImageLoadProxy: ImageLoadServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let cachedImagesURL = FileManager.default.getDirectory(
            withName: "CachedImages",
            inUserDomain: .cachesDirectory
        )
    }

    // MARK: - Private Properties

    private var imageLoadService: ImageLoadServiceProtocol

    // MARK: - Initializers

    init(imageLoadService: ImageLoadServiceProtocol) {
        self.imageLoadService = imageLoadService
    }

    // MARK: - Public Methods

    func loadImage(atURL url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {}

    // MARK: - Private Methods

//    private func fetchImageFromFileSystem(byUrl url: URL) -> Data? {
//        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    ////        FileManager.default.contents(atPath: url.)
//    }
}
