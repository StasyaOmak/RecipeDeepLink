// UserAuthData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Авторизация пользователя
struct UserAuthData: Codable {
    /// Электронная почта
    var email: String
    /// пароль
    var password: String
}
