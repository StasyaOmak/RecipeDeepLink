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
    
    var isHidden = false

    func isValidEmail(_ email: String) -> Bool {
        email.validateUsing(Constants.loginRegEx)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        password.validateUsing(Constants.passwordRegEx)
    }
}
