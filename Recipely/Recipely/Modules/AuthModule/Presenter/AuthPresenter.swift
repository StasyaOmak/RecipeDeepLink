// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

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

    //    private var storage: StorageManagerProtocol = StorageManager()
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
    }

    func loginButtonTapped(withPassword password: String?, withEmail email: String?) {
        view?.startIndicator()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [view] _ in
            view?.stopIndicator()
            if self.validator.isPasswordValid(password), self.validator.isEmailValid(email) {
                if let user = UserCaretaker.default.getUser() {
                    if user.email == email, user.password == password {
                        view?.setPasswordFieldStateTo(.plain)
                        view?.setEmailFieldStateTo(.plain)
                        self.coordinator?.endModule()
                    } else {
                        view?.setPasswordFieldStateTo(.highlited)
                        view?.showWarning()
                        view?.setEmailFieldStateTo(.highlited)
                    }
                } else {
                    let user = UserAuthData(email: email ?? "", password: password ?? "")
                    UserCaretaker.default.save(user)
                    view?.setPasswordFieldStateTo(.plain)
                    view?.setEmailFieldStateTo(.plain)
                    self.coordinator?.endModule()
                }
            } else {
                view?.setPasswordFieldStateTo(.highlited)
                view?.setEmailFieldStateTo(.highlited)
                view?.showWarning()
            }
        }
    }
}
