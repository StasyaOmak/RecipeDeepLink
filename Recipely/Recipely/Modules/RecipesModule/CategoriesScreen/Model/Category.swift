// Category.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Категория
struct Category {
    /// Название категории
    var dishType: DishType
    /// Название изображения категории
    var imageName: AssetImageName

    /// Массив категорий.
    static let categories: [Category] = [
        .init(dishType: .salad, imageName: .salad),
        .init(dishType: .soup, imageName: .soup),
        .init(dishType: .chicken, imageName: .chicken),
        .init(dishType: .meat, imageName: .meat),
        .init(dishType: .fish, imageName: .fish),
        .init(dishType: .sideDish, imageName: .sideDish),
        .init(dishType: .drinks, imageName: .drinks),
        .init(dishType: .pancake, imageName: .pancakes),
        .init(dishType: .desserts, imageName: .desserts)
    ]
}
