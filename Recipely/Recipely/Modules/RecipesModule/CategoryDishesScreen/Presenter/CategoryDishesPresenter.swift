// CategoryDishesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryDishesPresenter
protocol CategoryDishesPresenterProtocol {
    /// Список  блюд в категории.
    var dishes: [CategoryDish] { get }
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

    private(set) var dishes: [CategoryDish] = []
    private var initialDishes = CategoryDish.getDishes()
    private var conditionCalories = Condition.notPressed {
        willSet {
            updateDishesArray()
            view?.updateTable()
        }
    }

    private var conditionTime = Condition.notPressed {
        didSet {
            updateDishesArray()
            view?.updateTable()
        }
    }

    private var viewTitle: String

    // MARK: - Initializers

    init(view: CategoryDishesViewProtocol, coordinator: RecipesCoordinatorProtocol, viewTitle: String) {
        self.view = view
        self.coordinator = coordinator
        self.viewTitle = viewTitle
        dishes = initialDishes
    }

    typealias AreInIncreasingOrder = (CategoryDish, CategoryDish) -> Bool
    private func createPredicatesAccordingToCurrentSelectedConditions() -> [AreInIncreasingOrder] {
        var predicatesArray: [AreInIncreasingOrder] = []
        switch conditionTime {
        case .sortingMore:
            predicatesArray.append { $0.cookingTime < $1.cookingTime }
        case .sortingSmaller:
            predicatesArray.append { $0.cookingTime > $1.cookingTime }
        default:
            break
        }

        switch conditionCalories {
        case .sortingMore:
            predicatesArray.append { $0.numberCalories < $1.numberCalories }
        case .sortingSmaller:
            predicatesArray.append { $0.numberCalories > $1.numberCalories }
        default:
            break
        }
        return predicatesArray
    }

    private func getSortedCategoryDishes(using predicates: [AreInIncreasingOrder]) -> [CategoryDish] {
        initialDishes.sorted { lhsDish, rhsDish in
            for predicate in predicates {
                if !predicate(lhsDish, rhsDish), !predicate(rhsDish, lhsDish) {
                    continue
                }
                return predicate(lhsDish, rhsDish)
            }
            return false
        }
    }

    private func updateDishesArray() {
        let predicates = createPredicatesAccordingToCurrentSelectedConditions()
        dishes = getSortedCategoryDishes(using: predicates)
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
