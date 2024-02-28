// UIAlertAction+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIAlertAction {
    /// Создает экземпляр `UIAlertAction` с возможностью опускания некоторых параметров для упрощения инициализации.
    /// - Parameters:
    ///   - title: Текст, отображаемый на кнопке действия.
    ///   - style: Стиль действия, который может быть `.default`, `.cancel` или `.destructive`.
    ///            По умолчанию `.default`, что подразумевает стандартное действие без особой стилизации.
    ///   - completionHandler: Блок кода, который выполнится после выбора данного действия пользователем.
    ///                        Опциональный параметр, по умолчанию пустая функция, что означает отсутствие
    /// дополнительных действий после нажатия.
    ///
    convenience init(
        title: String,
        style: UIAlertAction.Style = .default,
        completionHandler: ((UIAlertAction) -> Void)? = { _ in }
    ) {
        self.init(title: title, style: style, handler: completionHandler)
    }
}
