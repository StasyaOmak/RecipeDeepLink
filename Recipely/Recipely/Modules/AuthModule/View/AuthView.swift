// AuthView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс общения с AuthView
protocol AuthViewInput: AnyObject {}

/// Вью экрана аутентификаци
final class AuthView: UIViewController {
    // MARK: - Public Properties

    var presenter: AuthPresenterInput?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

extension AuthView: AuthViewInput {}
