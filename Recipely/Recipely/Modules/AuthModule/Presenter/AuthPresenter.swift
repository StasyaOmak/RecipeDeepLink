// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Keychain

/// Интерфейс взаимодействия с AuthPresenter
protocol AuthPresenterProtocol: AnyObject {
    /// Функция для отображения об ошибке если не прошел валидность текст email
    func emailTextFieldValueChanged(to text: String?)
    /// Функция для отображения об ошибке если не прошел валидность текст password
    func loginButtonTapped(withPassword password: String?, withEmail email: String?)
    /// Функция для отображения предупреждений об ошибке при авторизации
    func showWarning()
}

/// Вью экрана аутентификаци
final class AuthPresenter {
    // MARK: - Private Properties

    private weak var coordinator: AuthCoordinatorProtocol?
    private weak var view: AuthViewProtocol?
    private var validator = Validator()

    // MARK: - Initializers

    init(view: AuthViewProtocol, coordinator: AuthCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension AuthPresenter: AuthPresenterProtocol {
    func showWarning() {
        view?.showWarning()
    }

    func emailTextFieldValueChanged(to text: String?) {
        if let text, validator.isEmailValid(text) || text.isEmpty {
            view?.setEmailFieldStateTo(.plain)
        } else {
            view?.setEmailFieldStateTo(.highlited)
        }
        if let text {
            view?.displayDeleteTextButton(isHidden: text.isEmpty)
        }
    }

    func loginButtonTapped(withPassword password: String?, withEmail email: String?) {
        view?.startIndicator()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [validator, view, coordinator] _ in
            view?.stopIndicator()
            if validator.isPasswordValid(password), validator.isEmailValid(email) {
                if Keychain.load("email") != nil, Keychain.load("password") != nil {
                    if Keychain.load("email") == email, Keychain.load("password") == password {
                        view?.setPasswordFieldStateTo(.plain)
                        view?.setEmailFieldStateTo(.plain)
                        coordinator?.endModule()
                    } else {
                        view?.setPasswordFieldStateTo(.highlited)
                        view?.setEmailFieldStateTo(.highlited)
                        view?.showWarning()
                    }
                } else {
                    _ = Keychain.save(email ?? "", forKey: "email")
                    _ = Keychain.save(password ?? "", forKey: "password")
                    view?.setPasswordFieldStateTo(.plain)
                    view?.setEmailFieldStateTo(.plain)
                    coordinator?.endModule()
                }
            } else {
                view?.setPasswordFieldStateTo(.highlited)
                view?.setEmailFieldStateTo(.highlited)
                view?.showWarning()
            }
        }
    }
}
