// DishDetailsScreenUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class DishDetailsScreenUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        login()
        app.collectionViews.firstMatch.cells.element(boundBy: 0).tap()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testCorrectDishTitle() throws {
        let selectedCell = app.tables.firstMatch.cells.element(boundBy: 0)
        let selectedCellTitle = selectedCell.staticTexts.element(boundBy: 0).label
        selectedCell.tap()

        let detailsTable = app.tables.firstMatch
        let dishLabel = detailsTable.cells.element(boundBy: 0).staticTexts.element(boundBy: 1).label
        XCTAssertEqual(selectedCellTitle, dishLabel, "Dish label doesn't match the title of previously selected cell")
    }

    func testBackButton() {
        app.tables.firstMatch.cells.element(boundBy: 0).tap()

        let backButton = app.navigationBars.firstMatch.buttons.element(boundBy: 0)
        XCTAssertTrue(backButton.exists, "There is no back button on DishDetailsScreen")
        backButton.tap()
    }

    func testAddToFavouritesButton() {
        sleep(1)
        app.tables.firstMatch.cells.element(boundBy: 0).tap()
        let addToFavouritesButton = app.navigationBars.firstMatch.buttons.element(boundBy: 2)
        _ = addToFavouritesButton.waitForExistence(timeout: 1)
        XCTAssertTrue(addToFavouritesButton.exists, "There is no addToFavourites button on DishDetailsScreen")
        addToFavouritesButton.tap()
        addToFavouritesButton.tap()
    }

    func testPullToRefresh() throws {
        app.tables.cells.element(boundBy: 0).tap()

        let table = app.tables.firstMatch
        let start = table.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.3))
        let finish = table.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 1.0))
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
