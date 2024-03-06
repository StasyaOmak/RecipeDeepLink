// CategoryDish.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о рецепте
struct CategoryDish {
    /// Название изображения блюда
    var nameImage: AssetImageName
    /// Название блюда
    var nameDish: String
    /// Время приготовления
    var cookingTime: Int
    /// Количество килокалорий
    var numberCalories: Int

    /// Возращает массив с моковыми данными по блюдам
    static func getDishes() -> [CategoryDish] {
        [
            .init(
                nameImage: .fishWithCorn,
                nameDish: "Simple Fish And Corn",
                cookingTime: 60,
                numberCalories: 274
            ),
            .init(
                nameImage: .bakedFish,
                nameDish: "Baked Fish with Lemon Herb Sauce",
                cookingTime: 90,
                numberCalories: 616
            ),
            .init(
                nameImage: .fishBurrito,
                nameDish: "Lemon and Chilli Fish Burrito",
                cookingTime: 90,
                numberCalories: 226
            ),
            .init(
                nameImage: .fishWithGreenPeas,
                nameDish: "Fast Roast Fish & Show Peas Recipes",
                cookingTime: 80,
                numberCalories: 94
            ),
            .init(
                nameImage: .salmonWithMelon,
                nameDish: "Salmon with Cantaloupe and Fried Shallots",
                cookingTime: 100,
                numberCalories: 410
            ),
            .init(
                nameImage: .fishWithPepper,
                nameDish: "Chilli and Tomato Fish",
                cookingTime: 100,
                numberCalories: 174
            ),
        ]
    }
}
