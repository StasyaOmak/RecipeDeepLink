// Dish.swift
// Copyright © RoadMap. All rights reserved.

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

    init(dto: RecipeDTO) {
        uri = dto.uri
        image = dto.image
        name = dto.label
        weight = dto.totalWeight
        cookingTime = dto.totalTime
        calories = dto.totalNutrients["ENERC_KCAL"]?.quantity
        carbohydrates = dto.totalNutrients["CHOCDF"]?.quantity
        fats = dto.totalNutrients["FAT"]?.quantity
        proteins = dto.totalNutrients["PROCNT"]?.quantity
        ingredientLines = dto.ingredientLines
    }
}
