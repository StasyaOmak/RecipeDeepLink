// ProfileScreenUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class ProfileScreenUITests: XCTestCase {
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

    func testEditNameButton() {
        app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
        let editButton = app.tables.firstMatch.cells.element(boundBy: 0).buttons.firstMatch
        _ = editButton.waitForExistence(timeout: 2)
        editButton.tap()

        let alert = app.alerts.firstMatch
        alert.buttons.element(boundBy: 1).tap()

        editButton.tap()
        let textField = app.alerts.firstMatch.textFields.firstMatch
        textField.typeText("Foo Barovich")
        alert.buttons.element(boundBy: 0).tap()
    }

    func testLoyalityProgramView() {
        app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
        let loyalityProgrammCell = app.tables.firstMatch.cells.element(boundBy: 1)
        loyalityProgrammCell.tap()
        app.buttons["exitButton"].firstMatch.tap()

        loyalityProgrammCell.tap()
        app.otherElements["PopoverDismissRegion"].firstMatch.tap()

        let loyalityProgrammView = app.otherElements["LoyalityProgrammView"].firstMatch
        loyalityProgrammCell.tap()
        loyalityProgrammView.swipeUp()
        loyalityProgrammView.swipeDown()
    }

    func testTermsAndPrivacyView() {
        app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
        let termsAndPrivacyCell = app.tables.firstMatch.cells.element(boundBy: 2)
        termsAndPrivacyCell.tap()
        let handleArea = app.otherElements["HandleArea"].firstMatch
        handleArea.tap()

        termsAndPrivacyCell.tap()
        let start = handleArea.coordinate(withNormalizedOffset: .zero)
        let end = start.withOffset(CGVector(dx: 0, dy: -200))
        start.press(forDuration: 0, thenDragTo: end)
        handleArea.swipeDown()
    }

    func testLogOutAlert() {
        app.tabBars.firstMatch.buttons.element(boundBy: 2).tap()
        let logOutCell = app.tables.firstMatch.cells.element(boundBy: 3)
        let logOutAlert = app.alerts.firstMatch
        logOutCell.tap()
        logOutAlert.buttons.element(boundBy: 1).tap()

        logOutCell.tap()
        logOutAlert.buttons.element(boundBy: 0).tap()
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
