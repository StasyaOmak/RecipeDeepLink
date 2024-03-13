// MemoryDish.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура, представляющая блюдо в памяти
struct MemoryDish: Codable {
    /// Идентификатор блюда
    let id: UUID
    /// Является ли блюдо избранным
    var isFavourite: Bool
    /// Название блюда
    var name: String
    /// Название изображения блюда
    var imageName: String?
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
}

extension MemoryDish {
    init(dish: Dish) {
        id = dish.id
        isFavourite = dish.isFavourite
        name = dish.name
        weight = dish.weight
        cookingTime = dish.cookingTime
        enerc = dish.enerc
        carbohydrates = dish.carbohydrates
        fats = dish.fats
        proteins = dish.proteins
        recipe = dish.recipe
        numberCalories = dish.numberCalories
    }

    func makeDish() -> Dish {
        Dish(
            id: id,
            isFavourite: isFavourite,
            name: name,
            weight: weight,
            cookingTime: cookingTime,
            enerc: enerc,
            carbohydrates: carbohydrates,
            fats: fats,
            proteins: proteins,
            recipe: recipe,
            numberCalories: numberCalories
        )
    }
}
