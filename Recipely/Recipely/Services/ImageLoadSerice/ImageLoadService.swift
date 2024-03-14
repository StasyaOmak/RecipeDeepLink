// ImageLoadService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ImageLoadServiceProtocol: ServiceProtocol {
    func loadImage(atURL url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}

final class ImageLoadService: ImageLoadServiceProtocol {
    var description: String {
        "ImageLoadService"
    }

    func loadImage(atURL url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}
