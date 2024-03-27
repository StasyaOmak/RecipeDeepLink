// RecipeTDO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура, представляющая информацию о конкретном рецепте.
struct RecipeDTO: Codable {
    /// URI рецепта.
    let uri: String
    /// Название рецепта.
    let label: String
    /// URL-адрес изображения рецепта.
    let image: String
    /// Общее время приготовления рецепта в секундах.
    let totalTime: Int
    /// Общий вес рецепта.
    let totalWeight: Float
    /// Список ингредиентов рецепта.
    let ingredientLines: [String]
    /// Общие питательные вещества рецепта, представленные в виде словаря, где ключ - название питательного вещества,
    /// значение - объект типа `Total`.
    let totalNutrients: [String: NutrientInfoDTO]
    /// Список адресов изображений рецепта разного размера
    let images: [String: ImageDTO]
    /// Тип блюда
    let dishType: [String]
}
