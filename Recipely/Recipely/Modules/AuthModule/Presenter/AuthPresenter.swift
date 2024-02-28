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
    func buttonTapped()
    func validateEmail(_ email: String)
    func validatePassword(_ email: String)
}

/// Вью экрана аутентификаци
final class AuthPresenter {
    // MARK: - Public Properties

    weak var view: AuthViewInput?
    private var validator = Validator()

    // MARK: - Private Properties

    private weak var coordinator: AuthCoordinatorProtocol?
//    private var validator = Validator()
}

extension AuthPresenter: AuthPresenterInput {
//    func validatePassword(_ password: String) {
//        if validator.isValidPassword(password) || password.isEmpty {
//            view?.setEmailFieldStateToNormal()
//        } else {
//            view?.showInputEmail()
//        }
//
//    }
    
    func validateEmail(_ email: String) {
        if validator.isValidEmail(email) || email.isEmpty {
            view?.setEmailFieldStateTo(.normal)
        } else {
            view?.setEmailFieldStateTo(.incorect)
        }
    }

    func buttonTapped() {
        if validator.isHidden == false {
            view?.setButtonImage(.lockIcon)
        } else {
            validator.isHidden = true
            view?.setButtonImage(.crossedEyeIcon)
        }
    }
}

extension AuthPresenter: AuthPresenterProtocol {
    func injectCoordinator(_ coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
