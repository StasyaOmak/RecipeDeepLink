// DishCategory.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перечисление, представляющее типы блюд.
enum DishCategory: String {
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
