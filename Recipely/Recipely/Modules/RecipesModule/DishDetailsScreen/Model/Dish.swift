// Dish.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура, представляющая блюдо.
struct Dish {
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

    static let fishAndCorn = Dish(
        name: "Simple Fish And Corn",
        imageName: .fishWithCorn,
        weight: 793,
        cookingTime: 60,
        enerc: 1322,
        carbohydrates: 10.78,
        fats: 10.00,
        proteins: 97.30,
        recipe: """
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
    )
}
