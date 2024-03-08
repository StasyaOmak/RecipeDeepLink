// UserMemento.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Пользователские данные в том виде, в ктором они будут храниться в памяти
struct UserMemento: Codable {
    /// Имя  пользователя
    var name: String?
    /// Название изображения профиля пользователя
    var profileImageName: String?
}
