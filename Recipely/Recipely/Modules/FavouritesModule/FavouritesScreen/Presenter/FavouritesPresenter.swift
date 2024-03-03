// FavouritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с FavouritesPresenter
protocol FavouritesPresenterProtocol: AnyObject {
    /// Возвращает массив секций рецептов для отображения в пользовательском интерфейсе.
    func getSections(forIndex index: Int) -> CategoryRecipes
    /// Возвращает количество подразделов рецептов
    func getAmountOfSubSections() -> Int
    /// удаляет рецепт из избранного.
    func removeItem(forIndex index: Int)
    /// проверяет пустой ли массив
    func checkEmptiness()
}

/// Вью экрана списка сохраненных рецептов
final class FavouritesPresenter {
    // MARK: - Private Properties

    private weak var coordinator: FavouritesCoordinatorProtocol?
    private weak var view: FavouritesView?
//    private var favourites = Favourites.category
    private var favourites = CategoryRecipes.makeRecipes()

    // MARK: - Initializers

    init(view: FavouritesView, coordinator: FavouritesCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    func checkEmptiness() {
        if favourites.isEmpty {
            view?.checkEmptiness(state: true)
        } else {
            view?.checkEmptiness(state: false)
        }
    }

    func removeItem(forIndex index: Int) {
        favourites.remove(at: index)
    }

    func getAmountOfSubSections() -> Int {
        favourites.count
    }

    func getSections(forIndex index: Int) -> CategoryRecipes {
        favourites[index]
    }
}
