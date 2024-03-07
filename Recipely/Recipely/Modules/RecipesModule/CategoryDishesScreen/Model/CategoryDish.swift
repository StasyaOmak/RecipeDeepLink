// CategoryDish.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о рецепте
struct CategoryDish {
    /// Название изображения блюда
    var nameImageName: AssetImageName
    /// Название блюда
    var dishName: String
    /// Время приготовления
    var cookingTime: Int
    /// Количество килокалорий
    var numberCalories: Int

    /// Возращает массив с моковыми данными по блюдам
    static func getDishes() -> [CategoryDish] {
        [
            .init(
                nameImageName: .fishWithCorn,
                dishName: "Simple Fish And Corn",
                cookingTime: 60,
                numberCalories: 274
            ),
            .init(
                nameImageName: .bakedFish,
                dishName: "Baked Fish with Lemon Herb Sauce",
                cookingTime: 90,
                numberCalories: 616
            ),
            .init(
                nameImageName: .fishBurrito,
                dishName: "Lemon and Chilli Fish Burrito",
                cookingTime: 90,
                numberCalories: 226
            ),
            .init(
                nameImageName: .fishWithGreenPeas,
                dishName: "Fast Roast Fish & Show Peas Recipes",
                cookingTime: 80,
                numberCalories: 94
            ),
            .init(
                nameImageName: .salmonWithMelon,
                dishName: "Salmon with Cantaloupe and Fried Shallots",
                cookingTime: 100,
                numberCalories: 410
            ),
            .init(
                nameImageName: .fishWithPepper,
                dishName: "Chilli and Tomato Fish",
                cookingTime: 100,
                numberCalories: 174
            ),
        ]
    }
}
