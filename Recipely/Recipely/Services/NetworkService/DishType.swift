//
//  DishType.swift
//  Recipely
//
//  Created by Tixon Markin on 13.03.2024.
//

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
            return "Salad"
        case .soup:
            return "Soup"
        case .chicken, .meat, .fish, .sideDish:
            return "Main course"
        case .pancake:
            return "Pancake"
        case .drinks:
            return "Drinks"
        case .desserts:
            return "Desserts"
        }
    }
}
