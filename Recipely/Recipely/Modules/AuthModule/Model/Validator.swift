// Validator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Валидатор учетных данных пользователя
struct Validator {
    // MARK: - Constants

    enum Constants {
        static let loginRegEx = ##"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,10}"##
        static let passwordRegEx = ##"[a-zA-Z0-9!"#$%&'()*+,-./:;<=>?@\[\]^_`{|}~]{8,32}"##
    }

    // MARK: - Public Methods

    // Метод для проверки на вилдность логина
    func isEmailValid(_ email: String?) -> Bool {
        guard let email else { return false }
        return email.validateUsing(Constants.loginRegEx)
    }

    // Метод для проверки на вилдность пароля
    func isPasswordValid(_ password: String?) -> Bool {
        guard let password else { return false }
        return password.validateUsing(Constants.passwordRegEx)
    }
}
