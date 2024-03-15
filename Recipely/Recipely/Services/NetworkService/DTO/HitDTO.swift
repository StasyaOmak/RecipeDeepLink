// HitDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура, представляющая отдельный элемент массива `hits` в JSON-ответе.
struct HitDTO: Codable {
    /// Объект типа `RecipeDTO`, содержащий информацию о конкретном рецепте.
    let recipe: RecipeDTO
}
