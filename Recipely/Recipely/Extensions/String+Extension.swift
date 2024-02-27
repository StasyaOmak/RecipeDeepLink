// String+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для удобного создания NSMutableAttributedString из String
extension String {
    /// Создает NSMutableAttributedString из текущей строки
    func attributed() -> NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}

extension String {
    /// Примеяет к строке переданное регулярное выражение
    func validateUsing(_ pattern: String) -> Bool {
        guard let regEx = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            print("Can not create regular expression from: \"\(pattern)\"")
            return false
        }
        let range = NSRange(location: 0, length: count)
        return regEx.firstMatch(in: self, range: range) != nil
    }
}
