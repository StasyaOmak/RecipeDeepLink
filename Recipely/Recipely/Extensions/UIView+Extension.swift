// UIView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение `UIView`, позволяющее добавлять несколько дочерних представлений за раз.
extension UIView {
    /// Добавляет несколько сабвью на текущий экземпляр вью.
    /// - Parameter views: Представления, которые нужно добавить на текущее вью.
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

    /// Добавляет несколько сабвью на текущий экземпляр вью.
    /// - Parameter views: Представления, которые нужно добавить на текущее вью.
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}

/// Расширение `UIView`, позволяющее переключать свойство `translatesAutoresizingMaskIntoConstraints` сразу у нескольких
/// представлений.
extension UIView {
    /// Устанавливает `translatesAutoresizingMaskIntoConstraints` в `false` для переданных представлений.
    /// - Parameter views: Представления, для которых нужно установить `translatesAutoresizingMaskIntoConstraints` в
    /// `false`.
    static func doNotTAMIC(for views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    /// Устанавливает `translatesAutoresizingMaskIntoConstraints` в `false` для переданных представлений.
    /// - Parameter views: Представления, для которых нужно установить `translatesAutoresizingMaskIntoConstraints` в
    /// `false`.
    static func doNotTAMIC(for views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}

/// Расширение для анимации мерцания.
extension UIView {
    /// Запускает анимацию мерцания на текущем представлении.
    /// - Parameters:
    ///   - speed: Скорость анимации.
    /// - Returns: Экземпляр CAGradientLayer, используемый для анимации.
    @discardableResult
    func startShimmerAnimation(speed: Double) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.8866160512, green: 0.9065348506, blue: 0.9061866403, alpha: 1).cgColor, #colorLiteral(red: 0.9450980392, green: 0.9607843137, blue: 0.9607843137, alpha: 1).cgColor, #colorLiteral(red: 0.8817833066, green: 0.9066954255, blue: 0.9019559622, alpha: 1).cgColor, #colorLiteral(red: 0.9450980392, green: 0.9607843137, blue: 0.9607843137, alpha: 1).cgColor]
        gradient.frame = bounds.insetBy(dx: -(bounds.width), dy: 0)
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = speed
        animation.repeatCount = .infinity
        animation.fromValue = -frame.width
        animation.toValue = frame.width
        animation.isRemovedOnCompletion = false

        layer.masksToBounds = true
        layer.addSublayer(gradient)
        gradient.add(animation, forKey: "shimmerKey")
        return gradient
    }

    /// Останавливает анимацию мерцания для указанного слоя.
    /// - Parameter layer: Слой, на котором проигрывается анимация мерцания.
    func stopShimmerAnimation() {
        layer.sublayers?.first?.removeFromSuperlayer()
    }
}
