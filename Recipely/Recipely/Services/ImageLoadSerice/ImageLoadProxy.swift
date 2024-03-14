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

    // MARK: - Public Properties

    var description: String {
        "ImageLoadProxy"
    }

    // MARK: - Private Properties

    private var imageLoadService: ImageLoadServiceProtocol

    // MARK: - Initializers

    init(imageLoadService: ImageLoadServiceProtocol) {
        self.imageLoadService = imageLoadService
    }

    // MARK: - Public Methods

    func loadImage(atURL url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            let imageName = url.lastPathComponent
            if let imageData = self.fetchImage(withName: imageName) {
                completion(imageData, nil, nil)
            } else {
                self.imageLoadService.loadImage(atURL: url) { [weak self] data, responce, error in
                    self?.saveImage(withName: imageName, imageData: data)
                    completion(data, responce, error)
                }
            }
        }
    }

    // MARK: - Private Methods

    private func fetchImage(withName imageName: String) -> Data? {
        guard let imageURL = Constants.cachedImagesURL?.appending(path: imageName),
              let imageData = FileManager.default.contents(atPath: imageURL.path())
        else { return nil }
        return imageData
    }

    @discardableResult
    private func saveImage(withName name: String, imageData data: Data?) -> Bool {
        guard let data,
              let imageURL = Constants.cachedImagesURL?
              .appending(path: name),
              FileManager.default.createFile(atPath: imageURL.path(), contents: data)
        else { return false }
        return true
    }
}
