// CategoryDishesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryDishesPresenter
protocol CategoryDishesPresenterProtocol {
    /// Получить название категории.
    func getTitle() -> String
    /// Запрос количества блюд
    func getNumberDishes() -> Int
    /// Сообщает по индексу информацию
    func getDish(forIndex index: Int) -> DataState
    /// Соощает о нажатии на ячейку какого либо блюда
    func didTapCell(atIndex index: Int)
    /// Сообщает о том: что вью появилас на экране
    func viewDidAppear()

    /// Сообщает о введенном пользователем заначениии поиска
    func searchBarTextChanged(to text: String)
    /// Сообщает об изменеии статуса сортировки по калориям
    func caloriesSortControlChanged(toState state: SortState)
    /// Сообщает об изменеии статуса сортировки по времени приготовления
    func timeSortControlChanged(toState state: SortState)
}

/// Презентер экрана категории рецептов
final class CategoryDishesPresenter {
    // MARK: - Types

    typealias AreDishesInIncreasingOrder = (CategoryDish, CategoryDish) -> Bool

    // MARK: - Private Properties

    private weak var view: CategoryDishesViewProtocol?
    private weak var coordinator: RecipesCoordinatorProtocol?

    private var viewTitle: String
    private var isDataAvalible = false
    private var dishes: [CategoryDish] = []
    private var initialDishes = CategoryDish.getDishes()
    private var caloriesSortState = SortState.none {
        didSet {
            updateDishesArray()
            view?.reloadDishes()
        }
    }

    private var timeSortState = SortState.none {
        didSet {
            updateDishesArray()
            view?.reloadDishes()
        }
    }

    // MARK: - Initializers

    init(view: CategoryDishesViewProtocol, coordinator: RecipesCoordinatorProtocol, viewTitle: String) {
        self.view = view
        self.coordinator = coordinator
        self.viewTitle = viewTitle
        dishes = initialDishes
    }

    // MARK: - Private Methods

    private func createPredicatesAccordingToCurrentSelectedConditions() -> [AreDishesInIncreasingOrder] {
        var predicatesArray: [AreDishesInIncreasingOrder] = []
        switch timeSortState {
        case .accending:
            predicatesArray.append { $0.cookingTime < $1.cookingTime }
        case .deccending:
            predicatesArray.append { $0.cookingTime > $1.cookingTime }
        default:
            break
        }

        switch caloriesSortState {
        case .accending:
            predicatesArray.append { $0.numberCalories < $1.numberCalories }
        case .deccending:
            predicatesArray.append { $0.numberCalories > $1.numberCalories }
        default:
            break
        }
        return predicatesArray
    }

    private func getSortedCategoryDishes(using predicates: [AreDishesInIncreasingOrder]) -> [CategoryDish] {
        dishes.sorted { lhsDish, rhsDish in
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

    private func receivedData() {
        isDataAvalible = true
        view?.reloadDishes()
    }
}

extension CategoryDishesPresenter: CategoryDishesPresenterProtocol {
    func getTitle() -> String {
        viewTitle
    }

    func getNumberDishes() -> Int {
        dishes.count
    }

    func getDish(forIndex index: Int) -> DataState {
        isDataAvalible ? .data(dishes[index]) : .noData
    }

    func didTapCell(atIndex index: Int) {
        if index == 0 {
            coordinator?.showDishDetailsScreen()
        }
    }

    func viewDidAppear() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            self.receivedData()
        }
    }

    func searchBarTextChanged(to text: String) {
        if text.count < 3 {
            dishes = initialDishes
        } else {
            dishes = dishes.filter { $0.nameDish.lowercased().contains(text.lowercased()) }
        }
        updateDishesArray()
        view?.reloadDishes()
    }

    func caloriesSortControlChanged(toState state: SortState) {
        caloriesSortState = state
    }

    func timeSortControlChanged(toState state: SortState) {
        timeSortState = state
    }
}
