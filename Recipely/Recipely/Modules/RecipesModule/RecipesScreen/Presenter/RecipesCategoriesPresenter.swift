// RecipesCategoriesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с RecipesPresenter
protocol RecipesCategoriesPresenterProtocol: AnyObject {
    /// Получить количество категорий рецептов.
    func getNumberOfCategories() -> Int
    /// Получить категорию по указанному индексу
    func getCategory(forIndex index: Int) -> Category
    /// Обработатка выбора категории рецептов.
    func didSelectCategory(atIndex index: Int)
}

/// Вью экрана списка рецептов
final class RecipesCategoriesPresenter {
    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinatorProtocol?
    private weak var view: RecipesCategoriesViewProtocol?
    private var recipes = RecipesCategories()

    // MARK: - Initializers

    init(view: RecipesCategoriesViewProtocol, coordinator: RecipesCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension RecipesCategoriesPresenter: RecipesCategoriesPresenterProtocol {
    func getNumberOfCategories() -> Int {
        recipes.categories.count
    }

    func getCategory(forIndex index: Int) -> Category {
        recipes.categories[index]
    }

    func didSelectCategory(atIndex index: Int) {
        coordinator?.showCategoryScreen(withTitle: recipes.categories[index].name)
    }
}
