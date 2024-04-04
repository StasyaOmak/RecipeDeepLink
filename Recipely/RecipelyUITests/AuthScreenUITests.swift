// AuthScreenUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class AuthScreenUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testAuthFields() {
        let loginTF = app.textFields.element(boundBy: 0)
        let passwordTF = app.textFields.element(boundBy: 1)
        let loginBtn = app.buttons["Login"]

        loginTF.tap()
        loginTF.typeText("incorrect email")
        passwordTF.tap()
        passwordTF.typeText("incorrect password")
        loginBtn.tap()

        sleep(3)

        loginTF.tap()
        loginTF.clearText()
        loginTF.typeText("Q@q.qq")
        passwordTF.tap()
        passwordTF.clearText()
        passwordTF.typeText("Qqqqqqqq")
        loginBtn.tap()
    }
}
