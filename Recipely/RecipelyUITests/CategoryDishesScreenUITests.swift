// CategoryDishesScreenUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class CategoryDishesScreenUITests: XCTestCase {
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

    func testCorrectTitle() throws {
        let selectedCellIndex = 2
        let collection = app.collectionViews.firstMatch
        let supposedTitle = collection.cells
            .element(boundBy: selectedCellIndex).staticTexts.firstMatch.label

        collection.cells.element(boundBy: selectedCellIndex).tap()
        let title = app.navigationBars.firstMatch.children(matching: .staticText).firstMatch.label
        XCTAssertEqual(supposedTitle, title, "CategoryDishes screen title is not the same as title of selected cell")
    }

    func testSearchField() throws {
        app.collectionViews.firstMatch.cells.element(boundBy: 0).tap()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "There is no search field on CategoryDishes screen")
        XCTAssertFalse(
            app.staticTexts["Nothing found"].isHittable,
            "Placeholder view shoul be not shown when table has more than 0 rows"
        )
        searchField.tap()
        searchField.typeText("asdfasdf")

        let table = app.tables.firstMatch
        XCTAssertTrue(table.cells.count == 0, "Showing table on incorrect search query")
        XCTAssertTrue(
            app.staticTexts["Nothing found"].isHittable,
            "Placeholder view shoul be shown when table has 0 rows"
        )
        searchField.buttons.firstMatch.tap()
    }

    func testFilters() throws {
        app.collectionViews.firstMatch.cells.element(boundBy: 0).tap()

        let caloriesFilter = app.staticTexts["Calories"]
        XCTAssertTrue(caloriesFilter.exists, "There is no calories filter on CategoryDishes screen")
        let timeFilter = app.staticTexts["Time"]
        XCTAssertTrue(caloriesFilter.exists, "There is no time filter on CategoryDishes screen")

        timeFilter.tap()
        caloriesFilter.tap()
        timeFilter.tap()
        caloriesFilter.tap()
        timeFilter.tap()
        caloriesFilter.tap()
    }

    func testPullToRefresh() throws {
        app.collectionViews.firstMatch.cells.element(boundBy: 0).tap()

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
