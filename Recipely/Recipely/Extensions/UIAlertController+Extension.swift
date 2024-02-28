// UIAlertController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIAlertController {
    /// Создает экземпляр `UIAlertController` с возможностью опускания некоторых параметров для упрощения инициализации.
    /// - Parameters:
    ///   - title: Заголовок алерта. Опциональный параметр, по умолчанию `nil`.
    ///   - message: Сообщение алерта. Опциональный параметр, по умолчанию `nil`.
    ///   - style: Стиль алерта, который может быть `.alert` или `.actionSheet`. По умолчанию `.alert`.
    convenience init(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert
    ) {
        self.init(title: title, message: message, preferredStyle: style)
    }
}
