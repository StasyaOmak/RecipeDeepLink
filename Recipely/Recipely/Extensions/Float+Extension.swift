// Float+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

extension Float {
    /// Возвращает чистое представление числа с плавающей точкой, удаляя конечные нули после десятичной точки, если они
    /// существуют.
    var cleanValue: String {
        if truncatingRemainder(dividingBy: 1) == 0 {
            String(format: "%.0f", self)
        } else {
            String(self)
        }
    }

    func withDecimalPlaces(_ numberOfPlaces: Int) -> String {
        guard numberOfPlaces >= 0 else { return String(self) }
        return String(format: "%.\(numberOfPlaces)f", self)
    }
}
