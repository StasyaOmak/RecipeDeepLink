// Category.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Категория
struct Category {
    /// Название категории
    var dishType: DishType
    /// Название изображения категории
    var imageName: String

    /// Массив категорий.
    static let categories: [Category] = [
        .init(dishType: .salad, imageName: AssetImage.DishCategoryImages.salad.name),
        .init(dishType: .soup, imageName: AssetImage.DishCategoryImages.soup.name),
        .init(dishType: .chicken, imageName: AssetImage.DishCategoryImages.chicken.name),
        .init(dishType: .meat, imageName: AssetImage.DishCategoryImages.meat.name),
        .init(dishType: .fish, imageName: AssetImage.DishCategoryImages.fish.name),
        .init(dishType: .sideDish, imageName: AssetImage.DishCategoryImages.sideDish.name),
        .init(dishType: .drinks, imageName: AssetImage.DishCategoryImages.drinks.name),
        .init(dishType: .pancake, imageName: AssetImage.DishCategoryImages.pancakes.name),
        .init(dishType: .desserts, imageName: AssetImage.DishCategoryImages.desserts.name)
    ]
}
