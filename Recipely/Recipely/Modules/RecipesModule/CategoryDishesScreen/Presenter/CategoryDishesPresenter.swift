// CategoryDishesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryDishesPresenter
protocol CategoryDishesPresenterProtocol {
    /// Сообщает о загрузке вью
    func viewLoaded()
    /// Состояние загрузки данных
    var state: ViewState<[Dish]> { get }
    /// Получить название категории.
    func getTitle() -> String
    /// Получить данные изображения для ячейки по индексу
    func getImageForCell(atIndex index: Int, completion: @escaping (Data, Int) -> ())

    /// Соощает о нажатии на ячейку какого либо блюда
    func didTapCell(atIndex index: Int)
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

    typealias AreDishesInIncreasingOrder = (Dish, Dish) -> Bool

    // MARK: - Constants

    private enum Constants {
        static let userOpenedDishScreenLogMessage = "Пользователь открыл рецепт блюда "
        static let vegetarianText = "vegetarian"
    }

    // MARK: - Private Properties

    private weak var view: CategoryDishesViewProtocol?
    private weak var coordinator: RecipesCoordinatorProtocol?
    private weak var networkService: NetworkServiceProtocol?
    private weak var imageLoadService: ImageLoadServiceProtocol?
    private(set) var state: ViewState<[Dish]> = .loading {
        didSet {
            view?.updateState()
        }
    }

    private var category: DishCategory
    var dishes: [Dish] = []

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

    init(
        view: CategoryDishesViewProtocol,
        coordinator: RecipesCoordinatorProtocol,
        networkService: NetworkServiceProtocol?,
        imageLoadService: ImageLoadServiceProtocol?,
        category: DishCategory
    ) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        self.imageLoadService = imageLoadService
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

//
//    private func updateDishes() {
//        let predicates = createPredicatesAccordingToCurrentSelectedConditions()
//        dishes = getSortedCategoryDishes(using: predicates)
//    }

    private func updateDishes(searchPredicate: String? = nil) {
        var health: String?
        if case .sideDish = category {
            health = Constants.vegetarianText
        }

        var query: String?
        switch category {
        case .chicken, .meat, .fish:
            query = category.rawValue
            if searchPredicate != nil {
                query?.append(" ")
            }
        default:
            break
        }

        if let searchPredicate {
            if query != nil {
                query?.append(searchPredicate)

            } else {
                query = searchPredicate
            }
        }

        state = .loading
        networkService?.searchForDishes(dishType: category, health: health, query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(dishes):
                    self?.state = !dishes.isEmpty ? .data(dishes) : .noData
                case let .failure(error):
                    self?.state = .error(error)
                }
            }
        }
    }
}

extension CategoryDishesPresenter: CategoryDishesPresenterProtocol {
    func viewLoaded() {
        updateDishes()
    }

    func getTitle() -> String {
        category.rawValue
    }

    func getImageForCell(atIndex index: Int, completion: @escaping (Data, Int) -> ()) {
        guard case let .data(dishes) = state,
              let url = URL(string: dishes[index].image)
        else { return }
        imageLoadService?.loadImage(atURL: url) { data, _, _ in
            if let data {
                completion(data, index)
            }
        }
    }

    func didTapCell(atIndex index: Int) {
//        LogAction.log(Constants.userOpenedDishScreenLogMessage + dishes[index].name)
//        guard let dish = DishesService.shared.getDish(byId: dishes[index].id) else { return }
//        coordinator?.showDishDetailsScreen(with: dish)
    }

    func searchBarTextChanged(to text: String) {
        updateDishes(searchPredicate: text)
    }

    func caloriesSortControlChanged(toState state: SortState) {
        caloriesSortState = state
    }

    func timeSortControlChanged(toState state: SortState) {
        timeSortState = state
    }
}
