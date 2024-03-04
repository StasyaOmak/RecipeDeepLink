// Category.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Категория
struct Category {
    /// Название категории
    var name: String
    /// Название изображения категории
    var imageName: AssetImageName

    /// Массив категорий.
    static let categories: [Category] = [
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
