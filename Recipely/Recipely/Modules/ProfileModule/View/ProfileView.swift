// ProfileView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс общения с ProfileView
protocol ProfileViewInput: AnyObject {}

/// Вью экрана профиля пользователя
final class ProfileView: UIViewController {
    // MARK: - Public Properties

    var presenter: ProfilePresenterInput?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension ProfileView: ProfileViewInput {}
