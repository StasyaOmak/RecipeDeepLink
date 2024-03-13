// DishesService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Обьект занимающийся управлением общим массивом блюд
final class DishesService {
    // MARK: - Public Properties

    static let shared = DishesService()

    // MARK: - Private Properties

    private var loader = DishesLoader()
    private var dishes: [Dish] = []
    private var listenersMap: [String: DishHandler] = [:]

    // MARK: - Initializers

    private init() {
        dishes = loader.loadDishes()
    }

    // MARK: - Public Methods

    func addToFavourites(dish: Dish) {
        guard let updateIndex = dishes.firstIndex(where: { $0 == dish }) else { return }
        dishes[updateIndex].isFavourite = true
        loader.saveDish(dish)
        listenersMap.values.forEach { $0(dishes[updateIndex]) }
    }

    func removeFromFavourites(dish: Dish) {
        guard let updateIndex = dishes.firstIndex(where: { $0 == dish }) else { return }
        dishes[updateIndex].isFavourite = false
        loader.saveDish(dish)
        listenersMap.values.forEach { $0(dishes[updateIndex]) }
    }

    func getDish(byId id: UUID) -> Dish? {
        let dish = dishes.first(where: { $0.id == id })
        return dish
    }

    func getDishes() -> [Dish] {
        dishes
    }

    func getFavouriteDishes() -> [Dish] {
        dishes.filter(\.isFavourite)
    }

    func addDishListener(for object: AnyObject, _ listener: @escaping DishHandler) {
        listenersMap[object.description] = listener
    }

    func removeListener(for object: AnyObject) {
        listenersMap.removeValue(forKey: object.description)
    }
}
