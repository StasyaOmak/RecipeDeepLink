// CategoriesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoriesPresenter
protocol CategoriesPresenterProtocol: AnyObject {
    /// Получить количество категорий
    func getNumberOfCategories() -> Int
    /// Получить категорию по указанному индексу
    func getCategory(forIndex index: Int) -> Category
    /// Обработатка выбора категории
    func didSelectCategory(atIndex index: Int)
}

/// Вью экрана списка категорий
final class CategoriesPresenter {
    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinatorProtocol?
    private weak var view: CategoriesViewProtocol?
    private var categories = Category.categories

    // MARK: - Initializers

    init(view: CategoriesViewProtocol, coordinator: RecipesCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension CategoriesPresenter: CategoriesPresenterProtocol {
    func getNumberOfCategories() -> Int {
        categories.count
    }

    func getCategory(forIndex index: Int) -> Category {
        categories[index]
    }

    func didSelectCategory(atIndex index: Int) {
        let categoryName = categories[index].imageName
        LogAction.log("пользовать перешел на Экран со списком рецептов из \(categoryName)")
        coordinator?.showCategoryDishesScreen(withTitle: categoryName.rawValue)
    }
}
