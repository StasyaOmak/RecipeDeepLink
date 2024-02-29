// CategoryPresent.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryPresenter
protocol CategoryPresenterProtocol {
    var category: [CategoryProtocol] { get set }
    func changesCaloriesSortingStatus()
    func changesTimeSortingStatus()
}

/// Вью экрана категории рецептов
final class CategoryPresenter {
    // MARK: - Public Properties

    var category: [CategoryProtocol] = Category.makeRecipes()

    // MARK: - Private Properties

    private weak var view: CategoryViewProtocol?
    private var conditionCalories = Condition.notPressed
    private var conditionTime = Condition.notPressed

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
