// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс иньекции зависимостей в AuthPresenter
protocol AuthPresenterProtocol: AnyObject {
    /// Добавляет координатор экрана аутентификации в качесте зависимости
    /// - Parameter AuthPresenter: Координатор экрана аутентификации
    func injectCoordinator(_ coordinator: AuthCoordinatorProtocol)    
}

/// Интерфейс общения с AuthPresenter
protocol AuthPresenterInput: AnyObject {
    func emailTextFieldValueChanged(to text: String?)
    func loginButtonTapped(withPassword password: String?)
}

/// Вью экрана аутентификаци
final class AuthPresenter {
    // MARK: - Public Properties

    weak var view: AuthViewInput?

    // MARK: - Private Properties

    private weak var coordinator: AuthCoordinatorProtocol?
    private var validator = Validator()
}

extension AuthPresenter: AuthPresenterInput {
    func emailTextFieldValueChanged(to text: String?) {
        if let text, validator.isEmailValid(text) || text.isEmpty {
            view?.setEmailFieldStateTo(.plain)
        } else {
            view?.setEmailFieldStateTo(.highlited)
        }
    }

    func loginButtonTapped(withPassword password: String?) {
        if let password, validator.isPasswordValid(password) || password.isEmpty {
            view?.setPasswordFieldStateTo(.plain)
        } else {
            view?.setPasswordFieldStateTo(.highlited)
        }
    }
}

extension AuthPresenter: AuthPresenterProtocol {
    func injectCoordinator(_ coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
