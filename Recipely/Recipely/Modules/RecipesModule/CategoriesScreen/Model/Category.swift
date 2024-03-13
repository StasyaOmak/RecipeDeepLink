// Category.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Категория
struct Category {
    /// Название категории
    var dishCategory: DishCategory
    /// Название изображения категории
    var imageName: AssetImageName

    /// Массив категорий.
    static let categories: [Category] = [
        .init(dishCategory: .salad, imageName: .salad),
        .init(dishCategory: .soup, imageName: .soup),
        .init(dishCategory: .chicken, imageName: .chicken),
        .init(dishCategory: .meat, imageName: .meat),
        .init(dishCategory: .fish, imageName: .fish),
        .init(dishCategory: .sideDish, imageName: .sideDish),
        .init(dishCategory: .drinks, imageName: .drinks),
        .init(dishCategory: .pancake, imageName: .pancakes),
        .init(dishCategory: .desserts, imageName: .desserts)
    ]
}
