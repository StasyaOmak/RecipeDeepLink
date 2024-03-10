// Dish.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Структура, представляющая блюдо.
struct Dish: Codable, Equatable {
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

    /// Идентификатор блюда
    let id: UUID
    /// Является ли блюдо избранным
    var isFavourite = false
    /// Название блюда
    var name: String
    /// Данные изображения
    var imageData: Data?
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

    static func == (lhs: Dish, rhs: Dish) -> Bool {
        lhs.id == rhs.id
    }
}

extension Dish {
    /// Возращает массив с моковыми данными по блюдам
    static func getDishes() -> [Dish] {
        [
            .init(
                id: UUID(),
                name: "Simple Fish And Corn",
                imageData: UIImage(.fishWithCorn)?.pngData(),
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
                id: UUID(),
                name: "Baked Fish with Lemon Herb Sauce",
                imageData: UIImage(.bakedFish)?.pngData(),
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
                id: UUID(),
                name: "Lemon and Chilli Fish Burrito",
                imageData: UIImage(.fishBurrito)?.pngData(),
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
                id: UUID(),
                name: "Fast Roast Fish & Show Peas Recipes",
                imageData: UIImage(.fishWithGreenPeas)?.pngData(),
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
                id: UUID(),
                name: "Salmon with Cantaloupe and Fried Shallots",
                imageData: UIImage(.salmonWithMelon)?.pngData(),
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
                id: UUID(),
                name: "Chilli and Tomato Fish",
                imageData: UIImage(.fishWithPepper)?.pngData(),
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
