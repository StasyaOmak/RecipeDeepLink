// UIAlertController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIAlertController {
    /// Удобный инициализатор в котором можно опускать параметры
    convenience init(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert
    ) {
        self.init(title: title, message: message, preferredStyle: style)
    }
}
