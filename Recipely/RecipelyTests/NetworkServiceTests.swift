// NetworkServiceTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import Recipely
import XCTest

final class RecipelyTests: XCTestCase {
    var networkService: NetworkServiceProtocol!
    let dishType = DishType.pancake
    let health: String? = nil
    let query = "cream"

    let uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_de240c6da6e848478643e2a08f6a04ea"

    override func setUpWithError() throws {
        networkService = NetworkService()
    }

    override func tearDownWithError() throws {
        networkService = nil
    }

    func testSearchForDishes() throws {
        let getDishesExpectation = XCTestExpectation(description: "Download dishes")
        networkService.searchForDishes(dishType: dishType, health: health, query: query) { result in
            switch result {
            case let .success(dishes):
                XCTAssertEqual(dishes.isEmpty, false)
            case .failure:
                XCTFail("Got nothing from net")
            }
            getDishesExpectation.fulfill()
        }
        wait(for: [getDishesExpectation], timeout: 2)
    }

    func testNegativeForDishes() throws {
        let getNegativeDishesExpectation = XCTestExpectation(description: "Download dishes")
        networkService.searchForDishes(dishType: dishType, health: health, query: query) { _ in
            getNegativeDishesExpectation.fulfill()
        }
        wait(for: [getNegativeDishesExpectation], timeout: 2)
    }

    func testPositiveGetDish() {
        let getPositiveDishExpectation = XCTestExpectation(description: "Download dish by uri")
        networkService.getDish(byURI: uri) { result in
            switch result {
            case let .success(dish):
                break
            case .failure:
                XCTFail("Got nothing from net")
            }
            getPositiveDishExpectation.fulfill()
        }
        wait(for: [getPositiveDishExpectation], timeout: 2)
    }

    func testNegativeGetDish() {
        let getNegativeExpectation = XCTestExpectation(description: "Download dish by uri")
        networkService.getDish(byURI: "bar") { result in
            switch result {
            case let .success(dish):
                XCTFail("WTF? Why result???")
            case .failure:
                break
            }
            getNegativeExpectation.fulfill()
        }
        wait(for: [getNegativeExpectation], timeout: 2)
    }
}
