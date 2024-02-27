// NSMutableAttributedString+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширения для удобной кофигурации некоторых аттрибутов
extension NSMutableAttributedString {
    /// Возвращает обьект с примененным указанным шрифтом для всей строки
    /// - Parameter font: Шрифт который будет применен ко всей строке
    /// - Returns: Текущий экземпляр, модифицированный указанным шрифтом
    func withFont(_ font: UIFont?) -> NSMutableAttributedString {
        guard let font else { return self }
        addAttributes([.font: font], range: NSRange(0 ..< string.count))
        return self
    }

    /// Модифицирует цвет строки переданным цветом
    /// - Parameter color: Цвет который будет применен ко всей строке
    /// - Returns: Текущий экземпляр, модифицированный указанным цветом
    func withColor(_ color: UIColor) -> NSMutableAttributedString {
        addAttributes([.foregroundColor: color], range: NSRange(0 ..< string.count))
        return self
    }
}
