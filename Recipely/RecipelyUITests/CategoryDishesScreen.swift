// CategoryDishesScreen.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class CategoryDishesScreen: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testCategoryDishesScreen() throws {
        print(app.debugDescription)

        let selectedCellIndex = 2
        let collection = app.collectionViews.firstMatch
        let supposedTitle = collection.cells
            .element(boundBy: selectedCellIndex).staticTexts.firstMatch.label

        collection.cells.element(boundBy: selectedCellIndex).tap()
        let title = app.navigationBars.firstMatch.children(matching: .staticText).firstMatch.label
        XCTAssertEqual(supposedTitle, title, "CategoryDishes screen title is not the same as title of selected cell")

        let caloriesFilter = app.staticTexts["Calories"]
        XCTAssertTrue(caloriesFilter.exists, "There is no calories filter on CategoryDishes screen")
        caloriesFilter.tap()

        let timeFilter = app.staticTexts["Time"]
        XCTAssertTrue(caloriesFilter.exists, "There is no time filter on CategoryDishes screen")
        timeFilter.tap()

        let searchField = app.descendants(matching: .searchField).firstMatch
        XCTAssertTrue(searchField.exists, "There is no search field on CategoryDishes screen")

        var table = app.tables.firstMatch
        searchField.tap()
        searchField.typeText("asdfasdf")
        XCTAssertTrue(table.cells.count == 0, "Showing table on incorrect search query")
        
        searchField.buttons.firstMatch.tap()

        print(app.debugDescription)


        table.swipeUp()

        table.swipeDown()
    }
}
