// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryPresenter
protocol CategoryPresenterProtocol {
    /// Список рецептов в категории.
    var recipes: [CategoryRecipesProtocol] { get }
    /// Получить заголовок категории.
    func getTitle() -> String
    /// Изменить статус сортировки по калориям.
    func changesCaloriesSortingStatus()
    /// Изменить статус сортировки по времени приготовления.
    func changesTimeSortingStatus()
    /// Соощает о тапе на какую либо ячейку
    func didTapCell(atIndex index: Int)
}

/// Презентер экрана категории рецептов
final class CategoryPresenter {
    // MARK: - Private Properties

    private weak var view: CategoryViewProtocol?
    private weak var coordinator: RecipesCoordinatorProtocol?

    private(set) var recipes: [CategoryRecipesProtocol] = CategoryRecipes.makeRecipes()
    private var conditionCalories = Condition.notPressed
    private var conditionTime = Condition.notPressed
    private var viewTitle: String

    // MARK: - Initializers

    init(view: CategoryViewProtocol, coordinator: RecipesCoordinatorProtocol, viewTitle: String) {
        self.view = view
        self.coordinator = coordinator
        self.viewTitle = viewTitle
    }
}

extension CategoryPresenter: CategoryPresenterProtocol {
    func getTitle() -> String {
        viewTitle
    }

    func changesTimeSortingStatus() {
        var number = conditionTime.rawValue
        number += 1
        let newCondition = Condition(rawValue: number % (Condition.allCases.count))
        conditionTime = newCondition ?? .notPressed
        view?.changesTimeSortingStatus(condition: conditionTime)
    }

    func changesCaloriesSortingStatus() {
        var number = conditionCalories.rawValue
        number += 1
        let newCondition = Condition(rawValue: number % (Condition.allCases.count))
        conditionCalories = newCondition ?? .notPressed
        view?.changesCaloriesSortingStatus(condition: conditionCalories)
    }

    func didTapCell(atIndex index: Int) {
        if index == 0 {
            coordinator?.showRecipeDetailScreen(forRecipe: "cdddd")
        }
    }
}
