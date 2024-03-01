// RecipesCategories.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура, представляющая коллекцию категорий рецептов.
struct RecipesCategories {
    /// Массив категорий рецептов.
    let categories: [Category] = [
        .init(name: "Salad", imageName: .salad),
        .init(name: "Soup", imageName: .soup),
        .init(name: "Chicken", imageName: .chicken),
        .init(name: "Meat", imageName: .meat),
        .init(name: "Fish", imageName: .fish),
        .init(name: "Side dish", imageName: .sideDish),
        .init(name: "Drinks", imageName: .drinks),
        .init(name: "Pancake", imageName: .pancakes),
        .init(name: "Desserts", imageName: .desserts)
    ]
}
