// UIView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение позволяющее добавлять несколько дочерних вью за раз
extension UIView {
    /// Добавляет несколько сабвюь на текущий экземпляр вью
    /// - Parameter views: Вью которые надо добавить на текущее вью
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

    /// Добавляет несколько сабвюь на текущий экземпляр вью
    /// - Parameter views: Вью которые надо добавить на текущее вью
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}

/// Расширение позволяющее переключать translatesAutoresizingMaskIntoConstraints сразу у нескольких view.
extension UIView {
    /// Устанавливает translatesAutoresizingMaskIntoConstraints в false для переданных вью
    /// - Parameter views: Вью которые для которых надо установить translatesAutoresizingMaskIntoConstraints в false
    static func doNotTAMIC(for views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    /// Устанавливает translatesAutoresizingMaskIntoConstraints в false для переданных вью
    /// - Parameter views: Вью которые для которых надо установить translatesAutoresizingMaskIntoConstraints в false
    static func doNotTAMIC(for views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
