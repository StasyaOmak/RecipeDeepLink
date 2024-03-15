// FavouritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с FavouritesPresenter
protocol FavouritesPresenterProtocol: AnyObject {
    /// Возвращает количество подразделов рецептов
    func getNumberOfDishes() -> Int
    /// Возвращает массив секций рецептов для отображения в пользовательском интерфейсе.
    func getDish(forIndex index: Int) -> Dish
}

/// Презентер экрана списка сохраненных рецептов
final class FavouritesPresenter {
    // MARK: - Private Properties

    private weak var coordinator: FavouritesCoordinatorProtocol?
    private weak var view: FavouritesViewProtocol?
    private var favouriteDishes: [Dish] = []

    // MARK: - Initializers

    init(view: FavouritesView, coordinator: FavouritesCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    func getNumberOfDishes() -> Int {
        favouriteDishes.count
    }

    func getDish(forIndex index: Int) -> Dish {
        favouriteDishes[index]
    }
}
