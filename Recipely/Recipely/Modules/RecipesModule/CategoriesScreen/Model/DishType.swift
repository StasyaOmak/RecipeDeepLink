// DishType.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перечисление, представляющее типы блюд.
enum DishType: String, Codable {
    /// Салаты
    case salad = "Salad"
    /// Супы
    case soup = "Soup"
    /// Курица
    case chicken = "Chicken"
    /// Мясо
    case meat = "Meat"
    /// Рыба
    case fish = "Fish"
    /// Гарниры
    case sideDish = "Side Dish"
    /// Блины
    case pancake = "Pancake"
    /// Напитки
    case drinks = "Drinks"
    /// Десерты
    case desserts = "Desserts"

    /// Возвращает строковое представление типа блюда для указания в запросе.
    var stringValue: String {
        switch self {
        case .salad:
            "salad"
        case .soup:
            "soup"
        case .chicken, .meat, .fish, .sideDish:
            "main course"
        case .pancake:
            "pancake"
        case .drinks:
            "drinks"
        case .desserts:
            "desserts"
        }
    }
}
