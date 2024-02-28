// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Удобная инициализация UIImage без использования строкового литерала
extension UIImage {
    /// Создает экземпляр `UIImage` на основе перечисления `AssetImageName`, устраняя необходимость в строковых
    /// литералах.
    /// - Parameter name: Кейс из перечисления `AssetImageName`, соответствующий названию нужного изображения.
    convenience init?(_ name: AssetImageName) {
        self.init(named: name.rawValue)
    }
}
