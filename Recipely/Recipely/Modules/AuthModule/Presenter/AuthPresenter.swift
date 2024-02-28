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
    func checkEmail(param: String)
}

/// Вью экрана аутентификаци
final class AuthPresenter {
    // MARK: - Public Properties

    weak var view: AuthViewInput?
    private var validator = Validator()

    // MARK: - Private Properties

    private weak var coordinator: AuthCoordinatorProtocol?
    private var validator = Validator()
}

extension AuthPresenter: AuthPresenterInput {
    func checkEmail(param: String) {
   let regexEmail = "^(?=.*[а-я])(?=.*[А-Я])(?=.*\\d)(?=.*[$@$!%*?&#])[А-Яа-я\\d$@$!%*?&#]{6,12}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regexEmail)
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
