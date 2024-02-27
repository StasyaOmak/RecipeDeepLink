// UIAlertAction+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIAlertAction {
    /// Основное значение для действия отмены
    static var denialTitle = "Cancel"
    /// Основное значение для чействия подтверждения
    static var confirmationTitle = "Ok"

    /// Возвращает действие отмены с обработчиком
    static func denial(
        style: UIAlertAction.Style = .default,
        completionHandler: ((UIAlertAction) -> Void)? = { _ in }
    ) -> UIAlertAction {
        self.init(title: denialTitle, style: .default, handler: completionHandler)
    }

    /// Возвращает действие подтверждения с обработчиком
    static func confimation(
        style: UIAlertAction.Style = .default,
        completionHandler: ((UIAlertAction) -> Void)? = { _ in }
    ) -> UIAlertAction {
        self.init(title: confirmationTitle, style: .default, handler: completionHandler)
    }

    /// Создает UIAlertAction.
    /// Более удобный инициализатор в возможностью опустить почти все параметры
    convenience init(
        title: String,
        style: UIAlertAction.Style = .default,
        completionHandler: ((UIAlertAction) -> Void)? = { _ in }
    ) {
        self.init(title: title, style: style, handler: completionHandler)
    }
}
