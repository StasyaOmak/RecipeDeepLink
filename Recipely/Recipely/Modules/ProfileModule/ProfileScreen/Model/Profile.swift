// Profile.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Профиль пользователя
struct Profile {
    /// Пользователь
    var user = User(profileImageName: .userIcon, name: "Surname Name")
    /// Список настроек
    var settings: [Setting] = [
        .init(icon: .starIcon, name: "Bonuses", type: .bonuses),
        .init(icon: .documentIcon, name: "Terms & Privacy Policy", type: .termsAndPrivacy),
        .init(icon: .logOutIcon, name: "Log out", type: .logOut)
    ]
}
