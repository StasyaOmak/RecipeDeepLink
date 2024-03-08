// UserMemento.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Хранение данных
struct UserMemento: Codable {
    /// Имя  пользователя
    var name: String?
    /// Изображение пользователя
    var profileImageName: String?
}
