// String+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для удобного создания `NSMutableAttributedString` из `String`.
extension String {
    /// Создает `NSMutableAttributedString` из текущей строки.
    func attributed() -> NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}

/// Расширение для удобной проверки строки на соответствие регулярному выражению.
extension String {
    /// Применяет к строке переданное регулярное выражение.
    /// - Parameter pattern: Шаблон регулярного выражения, к которому будет проверяться строка.
    /// - Returns: `true`, если строка соответствует регулярному выражению, иначе `false`.
    func validateUsing(_ pattern: String) -> Bool {
        guard let regEx = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            print("Can not create regular expression from: \"\(pattern)\"")
            return false
        }
        let range = NSRange(location: 0, length: count)
        return regEx.firstMatch(in: self, range: range) != nil
    }
}

extension String: Error {}
