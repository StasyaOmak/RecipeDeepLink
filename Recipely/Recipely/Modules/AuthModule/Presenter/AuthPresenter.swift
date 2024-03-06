// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с AuthPresenter
protocol AuthPresenterProtocol: AnyObject {
    /// функция для отображения об ошибке если не прошел валидность текст email
    func emailTextFieldValueChanged(to text: String?)
    /// функция для отображения об ошибке если не прошел валидность текст password
    func loginButtonTapped(withPassword password: String?)
    /// функция для отображения предупреждений об ошибке при авторизации
    func showWarning()
//    /// Сообщает о конце анимации спиннера
//    func didEndSpinningSpinner()
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
    }

    func loginButtonTapped(withPassword password: String?) {
        coordinator?.endModule()
        view?.startIndicator()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [view] _ in
            view?.stopIndicator()
            if let password, self.validator.isPasswordValid(password) {
                view?.setPasswordFieldStateTo(.plain)
            } else {
                view?.setPasswordFieldStateTo(.highlited)
                view?.showWarning()
            }
        }
    }
}
