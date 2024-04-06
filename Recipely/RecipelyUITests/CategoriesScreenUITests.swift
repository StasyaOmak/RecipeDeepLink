// CategoriesScreenUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class CategoriesScreenUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        login()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testCategoriesScreen() throws {
        let collection = app.collectionViews.firstMatch

        let title = app.navigationBars.firstMatch.children(matching: .staticText).firstMatch.label
        XCTAssertEqual(title, "Recipes")

        let numberOfCells = collection.cells.count
        XCTAssertGreaterThan(numberOfCells, 0, "There are 0 cells in collection view on CategoriesScreen")

        collection.cells.element(boundBy: 0).tap()
        let backButton = app.navigationBars.firstMatch.buttons.element(boundBy: 0)
        XCTAssertTrue(backButton.exists, "There is no back button on CategoriesScreen")
        backButton.tap()

        collection.swipeUp()
        collection.cells.element(boundBy: collection.cells.count - 1).tap()
        backButton.tap()

        collection.swipeDown()
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
