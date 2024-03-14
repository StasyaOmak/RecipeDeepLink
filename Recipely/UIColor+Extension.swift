// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIColor {
    static let accent = UIColor.userColor(hex: 0x72BABF)
    static let gradient = UIColor.userColor(hex: 0xDEEEEF)
    static let recipeView = UIColor.userColor(hex: 0xF1F5F5)
    static let searhBar = UIColor.userColor(hex: 0xF1F5F9)
    static let textAccent = UIColor.userColor(hex: 0x475C66)
    static let warnings = UIColor.userColor(hex: 0xEF6054)
    static let backgroundPlaceholder = UIColor.userColor(hex: 0xF2F5FA)

    /// Словарь уже инициализированных цветов
    private static var flyColorsMap: [Int: UIColor] = [:]

    /// Создает цвет из шестнадцатеричного представления.
    /// - Parameter hex: Шестнадцатеричное представление цвета.
    convenience init(_ hex: Int) {
        guard hex <= 0xFFFFFF else {
            self.init(white: 1, alpha: 1)
            return
        }
        let redComponent = CGFloat((hex & 0xFF0000) >> 16) / 255
        let greenComponent = CGFloat((hex & 0x00FF00) >> 8) / 255
        let blueComponent = CGFloat(hex & 0x0000FF) / 255
        self.init(red: redComponent, green: greenComponent, blue: blueComponent, alpha: 1)
    }

    /// Возвращает цвет из шестнадцатеричного представления.
    /// - Parameter hex: Шестнадцатеричное представление цвета.
    /// - Returns: Экземпляр цвета.
    static func userColor(hex: Int) -> UIColor {
        if let color = UIColor.flyColorsMap[hex] {
            return color
        }
        let color = UIColor(hex)
        UIColor.flyColorsMap[hex] = color
        return color
    }
}
