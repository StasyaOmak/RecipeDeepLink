// ImageLoadServiceTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Recipely
import XCTest

final class ImageLoadServiceTests: XCTestCase {
    var imageLoadService: ImageLoadServiceProtocol!
    let linkToImage =
        "https://binomen.ru/photo/uploads/posts/2024-02/1706893594_binomen-ru-p-dikaya-chernika-krasivo-7.jpg"

    override func setUpWithError() throws {
        imageLoadService = ImageLoadService()
    }

    override func tearDownWithError() throws {
        imageLoadService = nil
    }

    func testLoadImage() throws {
        let loadImageExpactation = XCTestExpectation(description: "Waiting for image")

        guard let imageURL = URL(string: linkToImage) else { return }
        imageLoadService.loadImage(atURL: imageURL) { data, response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            if let responce = response as? HTTPURLResponse {
                XCTAssertEqual(responce.statusCode / 100, 2)
            }
            loadImageExpactation.fulfill()
        }
        wait(for: [loadImageExpactation], timeout: 10)
    }

    func testNegativeLoadImage() throws {
        let loadImageNegativeExpactation = XCTestExpectation(description: "Waiting for image")

        guard let imageURL = URL(string: linkToImage + "foo") else { return }
        imageLoadService.loadImage(atURL: imageURL) { _, response, _ in
            if let responce = response as? HTTPURLResponse {
                XCTAssertNotEqual(responce.statusCode / 100, 2)
            }
            loadImageNegativeExpactation.fulfill()
        }
        wait(for: [loadImageNegativeExpactation], timeout: 10)
    }
}
