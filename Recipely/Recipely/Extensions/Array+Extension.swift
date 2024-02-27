// Array+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для удобной активации массива констрейнт
extension Array where Element == NSLayoutConstraint {
    /// Активация всех констрейнт из текущего массива
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}
