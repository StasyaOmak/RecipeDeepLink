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

extension UIView {
    func startShimmerAnimation(speed: Double) {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.813813347, green: 0.8384743575, blue: 0.8384743575, alpha: 1).cgColor, #colorLiteral(red: 0.9450980392, green: 0.9607843137, blue: 0.9607843137, alpha: 1).cgColor, #colorLiteral(red: 0.8156862745, green: 0.8392156863, blue: 0.8392156863, alpha: 1).cgColor, #colorLiteral(red: 0.9450980392, green: 0.9607843137, blue: 0.9607843137, alpha: 1).cgColor]
        gradient.frame = bounds.insetBy(dx: -(bounds.width), dy: 0)
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        layer.mask = gradient
//        layer.addSublayer(gradient)
        layer.masksToBounds = true

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = speed
        animation.repeatCount = Float.infinity
        animation.fromValue = -frame.width
        animation.toValue = frame.width
        animation.isRemovedOnCompletion = false
        gradient.add(animation, forKey: "shimmerKey")
    }

    func stopShimmerAnimation() {
        layer.mask = nil
    }
}

// #Preview {
//    let controller = UIViewController()
//    let view = UIView()
//    view.frame = .init(origin: .zero, size: CGSize(width: 300, height: 300)).offsetBy(dx: 100, dy: 300)
//    view.backgroundColor = .blue
////    view.clipsToBounds = true
//    view.layer.cornerRadius = 30
//
//    controller.view.addSubview(view)
//
//    view.startShimmerAnimation(speed: 4)
//    return controller
// }
