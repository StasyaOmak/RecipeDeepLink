// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс иньекции зависимостей в ProfilePresenter
protocol ProfilePresenterProtocol: AnyObject {
    /// Добавляет координатор экрана списка пофиля пользователя в качесте зависимости
    /// - Parameter coordinator: Координатор экрана пофиля пользователя
    func injectCoordinator(_ coordinator: ProfileCoordinatorProtocol)
}

/// Интерфейс общения с ProfilePresenter
protocol ProfilePresenterInput: AnyObject {}

/// Вью экрана пофиля пользователя
final class ProfilePresenter {
    // MARK: - Public Properties

    weak var view: ProfileView?

    // MARK: - Private Properties

    private weak var coordinator: ProfileCoordinatorProtocol?
    private var user = User()
}

extension ProfilePresenter: ProfilePresenterInput {}

extension ProfilePresenter: ProfilePresenterProtocol {
    func injectCoordinator(_ coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
