// XCUIElement+Extension.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

extension XCUIElement {
    func clearText() {
        guard let stringValue = value as? String else {
            return
        }
        // workaround for apple bug
        if let placeholderString = placeholderValue, placeholderString == stringValue {
            return
        }

        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        typeText(deleteString)
    }
}
