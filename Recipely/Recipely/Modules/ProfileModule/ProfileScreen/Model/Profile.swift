// Profile.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Профиль пользователя
struct Profile {
    /// Пользователь
    var user = User(profileImageData: nil, name: Local.Profile.surnameName)
    /// Список доступных подразделов, доступных пользователю
    var settings: [Setting] = [
        .init(
            icon: AssetImage.Icons.starIcon.name,
            name: Local.Profile.bonuses,
            type: .bonuses
        ),
        .init(
            icon: AssetImage.Icons.documentIcon.name,
            name: Local.Profile.termsPrivacyPolicy,
            type: .termsAndPrivacy
        ),
        .init(
            icon: AssetImage.Icons.logOutIcon.name,
            name: Local.Profile.logOut,
            type: .logOut
        )
    ]
    /// Список секций в профиле
    var sections: [ProfileSection] = [.userInfo, .subSection]
}
