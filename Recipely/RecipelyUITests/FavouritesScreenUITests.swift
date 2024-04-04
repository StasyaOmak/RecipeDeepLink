// FavouritesScreenUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class FavouritesScreenUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
        login()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testDeleteCell() {
        app.collectionViews.firstMatch.cells.element(boundBy: 0).tap()
        sleep(1)
        app.tables.firstMatch.cells.element(boundBy: 0).tap()

        sleep(1)
        let addToFavouritesButton = app.navigationBars.firstMatch.buttons.element(boundBy: 2)
        XCTAssertTrue(addToFavouritesButton.exists, "There is no addToFavourites button on DishDetailsScreen")
        addToFavouritesButton.tap()

        app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()

        let table = app.tables.firstMatch
        XCTAssertTrue(table.isHittable, "Table with at least one element must be visible")

        let cell = app.tables.firstMatch.cells.element(boundBy: 0)
        let start = cell.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5))
        let finish = cell.coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.5))
        start.press(forDuration: 1, thenDragTo: finish)
    }

    func login() {
        let loginTF = app.textFields.element(boundBy: 0)
        let passwordTF = app.textFields.element(boundBy: 1)
        let loginBtn = app.buttons["Login"]

        loginTF.tap()
        loginTF.clearText()
        loginTF.typeText("Q@q.qq")
        passwordTF.tap()
        passwordTF.clearText()
        passwordTF.typeText("Qqqqqqqq")
        loginBtn.tap()
    }
}
