// CategoryDishesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryDishesPresenter
protocol CategoryDishesPresenterProtocol {
    /// Получить название категории.
    func getTitle() -> String
    /// Соощает о нажатии на ячейку какого либо блюда
    func didTapCell(atIndex index: Int)
    /// Сообщает о введенном пользователем заначениии поиска
    func searchBarTextChanged(to text: String)
    /// Сообщает об изменеии статуса сортировки по калориям
    func caloriesSortControlChanged(toState state: SortState)
    /// Сообщает об изменеии статуса сортировки по времени приготовления
    func timeSortControlChanged(toState state: SortState)
    /// Получать данные по блюду
    func getDishes(text: String)
}

/// Презентер экрана категории рецептов
final class CategoryDishesPresenter {
    // MARK: - Types

    typealias AreDishesInIncreasingOrder = (Dish, Dish) -> Bool

    // MARK: - Constants

    private enum Constants {
        static let userOpenedDishScreenLogMessage = "Пользователь открыл рецепт блюда "
        static let vegetarianText = "Vegetarian"
    }

    // MARK: - Private Properties

    private weak var view: CategoryDishesViewProtocol?
    private weak var coordinator: RecipesCoordinatorProtocol?
    private let networkService = NetworkService()
    private var dishes: [Dish] = []
    private var category: DishCategory
    private var caloriesSortState = SortState.none {
        didSet {
            updateDishes()
//            view?.switchToState(.loading)
        }
    }

    private var timeSortState = SortState.none {
        didSet {
            updateDishes()
//            view?.switchToState(.loading)
        }
    }

    // MARK: - Initializers

    init(view: CategoryDishesViewProtocol, coordinator: RecipesCoordinatorProtocol, category: DishCategory) {
        self.view = view
        self.coordinator = coordinator
        self.category = category
    }

    // MARK: - Private Methods

    private func createPredicatesAccordingToCurrentSelectedConditions() -> [AreDishesInIncreasingOrder] {
        var predicates: [AreDishesInIncreasingOrder] = []
        switch timeSortState {
        case .accending:
            predicates.append { $0.cookingTime < $1.cookingTime }
        case .deccending:
            predicates.append { $0.cookingTime > $1.cookingTime }
        default:
            break
        }

//        switch caloriesSortState {
//        case .accending:
//            predicatesArray.append { $0.calories < $1.calories }
//        case .deccending:
//            predicatesArray.append { $0.calories > $1.calories }
//        default:
//            break
//        }
        return predicates
    }

    private func getSortedCategoryDishes(using predicates: [AreDishesInIncreasingOrder]) -> [Dish] {
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

    private func updateDishes() {
        let predicates = createPredicatesAccordingToCurrentSelectedConditions()
        dishes = getSortedCategoryDishes(using: predicates)
    }
}

extension CategoryDishesPresenter: CategoryDishesPresenterProtocol {
    func getTitle() -> String {
        category.rawValue
    }

    func getDishes(text: String) {
        var health: String?
        if case .sideDish = category {
            health = Constants.vegetarianText
        }

        var query: String?

        switch category {
        case .chicken, .meat, .fish:
            query = "\(category.rawValue) "

        default:
            break
        }

        query?.append(text)

        networkService.searchForDishes(
            dishType: category,
            health: health,
            query: query,
            completion: { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(dishes):
                        if dishes.isEmpty {
                            self?.view?.switchToState(.noData)
                        } else {
                            self?.view?.switchToState(.data(dishes))
                            self?.dishes = dishes
                        }
                    case let .failure(error):
                        self?.view?.switchToState(.error(error))
                    }
                }
            }
        )
    }

    func didTapCell(atIndex index: Int) {
        LogAction.log(Constants.userOpenedDishScreenLogMessage + dishes[index].name)
//        guard let dish = DishesService.shared.getDish(byId: dishes[index].id) else { return }
//        coordinator?.showDishDetailsScreen(with: dish)
    }

    func searchBarTextChanged(to text: String) {
        view?.switchToState(.loading)
        getDishes(text: text)
    }

    func caloriesSortControlChanged(toState state: SortState) {
        caloriesSortState = state
    }

    func timeSortControlChanged(toState state: SortState) {
        timeSortState = state
    }
}
