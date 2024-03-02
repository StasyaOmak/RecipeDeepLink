// CategoryDishesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryDishesPresenter
protocol CategoryDishesPresenterProtocol {
    /// Список  блюд в категории.
    var dishes: [CategoryDishProtocol] { get }
    /// Получить название категории.
    func getTitle() -> String
    /// Изменить статус сортировки по калориям.
    func changesCaloriesSortingStatus()
    /// Изменить статус сортировки по времени приготовления.
    func changesTimeSortingStatus()
    /// Соощает о нажатии на ячейку какого либо блюда
    func didTapCell(atIndex index: Int)
}

/// Презентер экрана категории рецептов
final class CategoryDishesPresenter {
    // MARK: - Private Properties

    private weak var view: CategoryDishesViewProtocol?
    private weak var coordinator: RecipesCoordinatorProtocol?

    private(set) var dishes: [CategoryDishProtocol] = CategoryDish.getDishes()
    private var conditionCalories = Condition.notPressed
    private var conditionTime = Condition.notPressed
    private var viewTitle: String

    // MARK: - Initializers

    init(view: CategoryDishesViewProtocol, coordinator: RecipesCoordinatorProtocol, viewTitle: String) {
        self.view = view
        self.coordinator = coordinator
        self.viewTitle = viewTitle
    }
}

extension CategoryDishesPresenter: CategoryDishesPresenterProtocol {
    func getTitle() -> String {
        viewTitle
    }

    func changesTimeSortingStatus() {
        conditionTime = conditionTime.next
        view?.changesTimeSortingStatus(condition: conditionTime)
    }

    func changesCaloriesSortingStatus() {
        conditionCalories = conditionCalories.next
        view?.changesCaloriesSortingStatus(condition: conditionCalories)
    }

    func didTapCell(atIndex index: Int) {
        if index == 0 {
            coordinator?.showDishDetailsScreen()
        }
    }
}
