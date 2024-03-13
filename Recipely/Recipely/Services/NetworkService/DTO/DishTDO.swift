//
//  DishTDO.swift
//  Recipely
//
//  Created by Tixon Markin on 13.03.2024.
//

import Foundation

/// Структура, представляющая информацию о конкретном блюде.
struct DishDTO: Codable {
    /// URI блюда.
    let uri: String
    /// Название блюда.
    let label: String
    /// URL-адрес изображения блюда.
    let image: String
    /// Общее время приготовления блюда в секундах.
    let totalTime: Int
    /// Общий вес блюда.
    let totalWeight: Double
    /// Список ингредиентов блюда.
    let ingredientLines: [String]
    /// Общие питательные вещества блюда, представленные в виде словаря, где ключ - название питательного вещества, значение - объект типа `Total`.
    let totalNutrients: [String: Total]
}
