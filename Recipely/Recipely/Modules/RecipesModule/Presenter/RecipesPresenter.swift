// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с RecipesPresenter
protocol RecipesPresenterProtocol: AnyObject {
    /// Получить количество категорий рецептов.
    func getNumberOfCategories() -> Int
    /// Получить категорию по указанному индексу
    func getCategory(forIndex index: Int) -> Category
    /// Обработатка выбора категории рецептов.
    func didSelectCategory(atIndex index: Int)
}

/// Вью экрана списка рецептов
final class RecipesPresenter {
    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinatorProtocol?
    private weak var view: RecipesViewProtocol?
    private var recipes = Recipes()

    // MARK: - Initializers

    init(view: RecipesViewProtocol, coordinator: RecipesCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension RecipesPresenter: RecipesPresenterProtocol {
    func getNumberOfCategories() -> Int {
        recipes.categories.count
    }

    func getCategory(forIndex index: Int) -> Category {
        recipes.categories[index]
    }

    func didSelectCategory(atIndex index: Int) {
        coordinator?.showCategoryScreen()
    }
}
