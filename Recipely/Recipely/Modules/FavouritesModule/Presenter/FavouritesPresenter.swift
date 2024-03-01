// FavouritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с FavouritesPresenter
protocol FavouritesPresenterProtocol: AnyObject {
    /// Возвращает массив секций рецептов для отображения в пользовательском интерфейсе.
    func getSections(forIndex index: Int) -> CategoryRecipes
    /// Возвращает количество подразделов в профиле пользователя.
    func getAmountOfSubSections() -> Int
}

/// Вью экрана списка сохраненных рецептов
final class FavouritesPresenter {
    // MARK: - Private Properties

    private weak var coordinator: FavouritesCoordinatorProtocol?
    private weak var view: FavouritesView?
//    private var favourites = CategoryRecipes.makeRecipes()
    private var favourites = Favourites.category

    // MARK: - Initializers

    init(view: FavouritesView, coordinator: FavouritesCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    func getAmountOfSubSections() -> Int {
        favourites.count
    }

    func getSections(forIndex index: Int) -> CategoryRecipes {
        favourites[index]
    }
}
