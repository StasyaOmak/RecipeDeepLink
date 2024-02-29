// CategoryPresent.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryPresenter
protocol CategoryPresenterProtocol {
    var recipes: [CategoryRecipesProtocol] { get }
    func changesCaloriesSortingStatus()
    func changesTimeSortingStatus()
}

/// Презентер экрана категории рецептов
final class CategoryPresenter {
    // MARK: - Private Properties

    private(set) var recipes: [CategoryRecipesProtocol] = CategoryRecipes.makeRecipes()
    private weak var view: CategoryViewProtocol?
    private var conditionCalories = Condition.notPressed
    private var conditionTime = Condition.notPressed
    private weak var coordinator: RecipesCoordinator?

    // MARK: - Initializers

    init(view: CategoryViewProtocol) {
        self.view = view
    }
}

extension CategoryPresenter: CategoryPresenterProtocol {
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
}
