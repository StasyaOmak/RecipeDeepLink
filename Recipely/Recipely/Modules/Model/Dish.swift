// Dish.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура, представляющая блюдо.
struct Dish: Codable {
    /// Идентификатор блюда
    let uri: String
    /// Сылка на изображение блюда
    let linkToImage: String
    /// Сылка на изображение блюда в сжатом формате
    let linkToThumbnailImage: String
    /// Название блюда
    let name: String
    /// Вес блюда.
    let weight: Double
    /// Время приготовления блюда в минутах.
    let cookingTime: Int
    /// Энергетическая ценность блюда.
    let calories: Float
    /// Количество углеводов в блюде.
    let carbohydrates: Float
    /// Количество жиров в блюде.
    let fats: Float
    /// Количество белков в блюде.
    let proteins: Float
    /// Рецепт блюда.
    let ingredientLines: [String]

    init(dto: RecipeDTO) {
        uri = dto.uri
        linkToImage = dto.image
        linkToThumbnailImage = dto.images["THUMBNAIL"]?.url ?? dto.image
        name = dto.label
        weight = dto.totalWeight
        cookingTime = dto.totalTime
        calories = dto.totalNutrients["ENERC_KCAL"]?.quantity ?? 0
        carbohydrates = dto.totalNutrients["CHOCDF"]?.quantity ?? 0
        fats = dto.totalNutrients["FAT"]?.quantity ?? 0
        proteins = dto.totalNutrients["PROCNT"]?.quantity ?? 0
        ingredientLines = dto.ingredientLines
    }
}
