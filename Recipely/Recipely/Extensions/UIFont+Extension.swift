// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для удобного получения пользовательских шрифтов.
extension UIFont {
    /// Возвращает пользовательский шрифт Verdana указанного размера.
    /// - Parameter size: Размер шрифта.
    /// - Returns: Экземпляр шрифта Verdana указанного размера, если доступен, иначе `nil`.
    static func verdana(size: CGFloat) -> UIFont? {
        userFont(name: "Verdana", size: size)
    }

    /// Возвращает жирный пользовательский шрифт Verdana указанного размера.
    /// - Parameter size: Размер шрифта.
    /// - Returns: Экземпляр жирного шрифта Verdana указанного размера, если доступен, иначе `nil`.
    static func verdanaBold(size: CGFloat) -> UIFont? {
        userFont(name: "Verdana-Bold", size: size)
    }

    /// Возвращает жирный курсивный пользовательский шрифт Verdana указанного размера.
    /// - Parameter size: Размер шрифта.
    /// - Returns: Экземпляр жирного курсивного шрифта Verdana указанного размера, если доступен, иначе `nil`.
    static func verdanaBoldItalic(size: CGFloat) -> UIFont? {
        userFont(name: "Verdana-BoldItalic", size: size)
    }

    /// Словарь уже инициализированных шрифтов
    private static var flyFontsMap: [String: UIFont] = [:]

    /// Возвращает пользовательский шрифт указанного имени и размера.
    /// - Parameters:
    ///   - name: Имя шрифта.
    ///   - size: Размер шрифта.
    /// - Returns: Экземпляр пользовательского шрифта указанного имени и размера, если доступен, иначе `nil`.
    static func userFont(name: String, size: CGFloat) -> UIFont? {
        let identifier = name + "\(size)"
        if let font = UIFont.flyFontsMap[identifier] {
            return font
        }
        let font = UIFont(name: name, size: size)
        UIFont.flyFontsMap[identifier] = font
        return font
    }
}
