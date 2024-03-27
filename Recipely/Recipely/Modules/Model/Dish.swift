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
    let weight: Float
    /// Тип блюда
    let category: String?
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
    let recipe: String
    /// Является ли рецепт любимым
    var isFavourite: Bool = false

    init(dto: RecipeDTO, category: DishType?) {
        uri = dto.uri
        linkToImage = dto.image
        linkToThumbnailImage = dto.images["THUMBNAIL"]?.url ?? dto.image
        name = dto.label
        weight = dto.totalWeight
        self.category = category?.rawValue
        cookingTime = dto.totalTime
        calories = dto.totalNutrients["ENERC_KCAL"]?.quantity ?? 0
        carbohydrates = dto.totalNutrients["CHOCDF"]?.quantity ?? 0
        fats = dto.totalNutrients["FAT"]?.quantity ?? 0
        proteins = dto.totalNutrients["PROCNT"]?.quantity ?? 0
        recipe = dto.ingredientLines.joined(separator: "\n")
    }

    init(cdDish: CDDish) {
        uri = cdDish.uri
        linkToImage = cdDish.linkToImage
        linkToThumbnailImage = cdDish.linkToThumbnailImage
        name = cdDish.name
        weight = cdDish.weight
        category = cdDish.category
        cookingTime = Int(cdDish.cookingTime)
        calories = cdDish.calories
        carbohydrates = cdDish.carbohydrates
        fats = cdDish.fats
        proteins = cdDish.proteins
        recipe = cdDish.recipe
        isFavourite = cdDish.isFavourite
    }
}
