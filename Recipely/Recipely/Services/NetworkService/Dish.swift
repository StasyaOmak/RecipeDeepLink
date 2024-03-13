//
//  Dish.swift
//  Recipely
//
//  Created by Tixon Markin on 13.03.2024.
//

import Foundation

/// Структура, представляющая блюдо.
struct Dish: Codable {
    /// Идентификатор блюда
    let uri: String
    /// Изображение блюда
    let image: String
    /// Название блюда
    let name: String
    /// Вес блюда.
    let weight: Double
    /// Время приготовления блюда в минутах.
    let cookingTime: Int
    /// Энергетическая ценность блюда.
    let calories: Double?
    /// Количество углеводов в блюде.
    let carbohydrates: Double?
    /// Количество жиров в блюде.
    let fats: Double?
    /// Количество белков в блюде.
    let proteins: Double?
    /// Рецепт блюда.
    let ingredientLines: [String]
    
    init(dto: DishDTO) {
        self.uri = dto.uri
        self.image = dto.image
        self.name = dto.label
        self.weight = dto.totalWeight
        self.cookingTime = dto.totalTime
        self.calories = dto.totalNutrients["ENERC_KCAL"]?.quantity
        self.carbohydrates = dto.totalNutrients["CHOCDF"]?.quantity
        self.fats = dto.totalNutrients["FAT"]?.quantity
        self.proteins = dto.totalNutrients["PROCNT"]?.quantity
        self.ingredientLines = dto.ingredientLines
    }
}
