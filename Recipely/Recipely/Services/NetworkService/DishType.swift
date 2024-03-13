// DishType.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перечисление, представляющее типы блюд.
enum DishType {
    /// Салат
    case salad
    /// Суп
    case soup
    /// Курица
    case chicken
    /// Мясо
    case meat
    /// Рыба
    case fish
    /// Гарнир
    case sideDish
    /// Блин
    case pancake
    /// Напитки
    case drinks
    /// Десерты
    case desserts

    /// Возвращает строковое представление типа блюда для указания в запросе.
    var stringValue: String {
        switch self {
        case .salad:
            "Salad"
        case .soup:
            "Soup"
        case .chicken, .meat, .fish, .sideDish:
            "Main course"
        case .pancake:
            "Pancake"
        case .drinks:
            "Drinks"
        case .desserts:
            "Desserts"
        }
    }
}
