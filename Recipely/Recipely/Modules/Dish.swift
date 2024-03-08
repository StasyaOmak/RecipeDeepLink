// Dish.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура, представляющая блюдо.
struct Dish {
    // MARK: - Constants

    private enum Constants {
        static let recipe = """
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        """
    }

    /// Название блюда
    var name: String
    /// Имя изображения блюда.
    var imageName: AssetImageName
    /// Вес блюда.
    var weight: Int
    /// Время приготовления блюда в минутах.
    var cookingTime: Int
    /// Энергетическая ценность блюда.
    var enerc: Float
    /// Количество углеводов в блюде.
    var carbohydrates: Float
    /// Количество жиров в блюде.
    var fats: Float
    /// Количество белков в блюде.
    var proteins: Float
    /// Рецепт блюда.
    var recipe: String
    /// Количество килокалорий
    var numberCalories: Int

    /// Возращает массив с моковыми данными по блюдам
    static func getDishes() -> [Dish] {
        [
            .init(
                name: "Simple Fish And Corn",
                imageName: .fishWithCorn,
                weight: 793,
                cookingTime: 60,
                enerc: 1322,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipe: Constants.recipe,
                numberCalories: 274
            ),

            .init(
                name: "Baked Fish with Lemon Herb Sauce",
                imageName: .bakedFish,
                weight: 793,
                cookingTime: 90,
                enerc: 1322,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipe: Constants.recipe,
                numberCalories: 616
            ),

            .init(
                name: "Lemon and Chilli Fish Burrito",
                imageName: .fishBurrito,
                weight: 793,
                cookingTime: 90,
                enerc: 1322,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipe: Constants.recipe,
                numberCalories: 226
            ),

            .init(
                name: "Fast Roast Fish & Show Peas Recipes",
                imageName: .fishWithGreenPeas,
                weight: 793,
                cookingTime: 80,
                enerc: 1322,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipe: Constants.recipe,
                numberCalories: 94
            ),

            .init(
                name: "Salmon with Cantaloupe and Fried Shallots",
                imageName: .salmonWithMelon,
                weight: 793,
                cookingTime: 100,
                enerc: 1322,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipe: Constants.recipe,
                numberCalories: 410
            ),

            .init(
                name: "Chilli and Tomato Fish",
                imageName: .fishWithPepper,
                weight: 793,
                cookingTime: 100,
                enerc: 1322,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipe: Constants.recipe,
                numberCalories: 174
            )
        ]
    }
}
