// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Удобная инициализация UIImage без использования строкового литерала
extension UIImage {
    /// Создает UIImage из значения в AssetImageName
    /// - Parameter name: Кейс из  AssetImageName соответствующий нужному изображению
    convenience init?(_ name: AssetImageName) {
        self.init(named: name.rawValue)
    }
}
