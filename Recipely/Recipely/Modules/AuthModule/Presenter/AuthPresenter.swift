// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Интерфейс иньекции зависимостей в AuthPresenter
protocol AuthPresenterProtocol: AnyObject {
    /// Добавляет координатор экрана аутентификации в качесте зависимости
    /// - Parameter AuthPresenter: Координатор экрана аутентификации
    func injectCoordinator(_ coordinator: AuthCoordinatorProtocol)
}

/// Интерфейс общения с AuthPresenter
protocol AuthPresenterInput: AnyObject {
    func buttonTapped()
}

/// Вью экрана аутентификаци
final class AuthPresenter {
    // MARK: - Public Properties

    weak var view: AuthViewInput?
    private let validator = Validator()

    // MARK: - Private Properties

    private weak var coordinator: AuthCoordinatorProtocol?
    private var profile = User()
}

extension AuthPresenter: AuthPresenterInput {
    func buttonTapped() {
        view?.setButtonImage(.lockIcon)
    }
}

extension AuthPresenter: AuthPresenterProtocol {
    func injectCoordinator(_ coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
