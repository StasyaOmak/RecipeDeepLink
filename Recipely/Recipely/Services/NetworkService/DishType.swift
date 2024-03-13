// DishType.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перечисление, представляющее типы блюд.
enum DishType {
    case salad
    case soup
    case chicken
    case meat
    case fish
    case sideDish
    case pancake
    case drinks
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
