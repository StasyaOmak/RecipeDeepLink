// CategoryDishesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryDishesPresenter
protocol CategoryDishesPresenterProtocol {
    /// Состояние загрузки данных
    var state: ViewState<[Dish]> { get }
    /// Сообщает о загрузке вью
    func requestDishesUpdate()
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

    private var dishType: DishType
    private var initialDishes: [Dish] = []
    private(set) var state: ViewState<[Dish]> = .loading {
        didSet {
            view?.updateState()
        }
    }

    private var caloriesSortState: SortState = .none {
        didSet {
            guard case let .data(dishes) = state else { return }
            state = .data(sortDishes(dishes))
        }
    }

    private var timeSortState: SortState = .none {
        didSet {
            guard case let .data(dishes) = state else { return }
            state = .data(sortDishes(dishes))
        }
    }

    // MARK: - Initializers

    init(
        view: CategoryDishesViewProtocol,
        coordinator: RecipesCoordinatorProtocol,
        networkService: NetworkServiceProtocol?,
        imageLoadService: ImageLoadServiceProtocol?,
        category: DishType
    ) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        self.imageLoadService = imageLoadService
        dishType = category
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

        switch caloriesSortState {
        case .accending:
            predicates.append { $0.calories < $1.calories }
        case .deccending:
            predicates.append { $0.calories > $1.calories }
        default:
            break
        }
        return predicates
    }

    private func sortDishes(_ dishes: [Dish]) -> [Dish] {
        let predicates = createPredicatesAccordingToCurrentSelectedConditions()
        return dishes.sorted { lhsDish, rhsDish in
            for predicate in predicates {
                if !predicate(lhsDish, rhsDish), !predicate(rhsDish, lhsDish) {
                    continue
                }
                return predicate(lhsDish, rhsDish)
            }
            return false
        }
    }

    private func updateDishes(searchPredicate: String? = nil) {
        var health: String?
        if case .sideDish = dishType {
            health = Constants.vegetarianText
        }
        state = .loading
        networkService?
            .searchForDishes(dishType: dishType, health: health, query: searchPredicate) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self else { return }
                    switch result {
                    case let .success(dishes):
                        let sortedDishes = self.sortDishes(dishes)
                        self.state = !dishes.isEmpty ? .data(sortedDishes) : .noData
                        if self.initialDishes.isEmpty {
                            self.initialDishes = dishes
                        }
                    case let .failure(error):
                        self.state = .error(error)
                    }
                }
            }
    }
}

extension CategoryDishesPresenter: CategoryDishesPresenterProtocol {
    func requestDishesUpdate() {
        updateDishes()
    }

    func getTitle() -> String {
        dishType.rawValue
    }

    func getImageForCell(atIndex index: Int, completion: @escaping (Data, Int) -> ()) {
        guard case let .data(dishes) = state,
              let url = URL(string: dishes[index].linkToThumbnailImage)
        else { return }
        imageLoadService?.loadImage(atURL: url) { data, _, _ in
            if let data {
                completion(data, index)
            }
        }
    }

    func didTapCell(atIndex index: Int) {
        if case let .data(dishes) = state {
            LogAction.log(Constants.userOpenedDishScreenLogMessage + dishes[index].name)
            coordinator?.showDishDetailsScreen(with: dishes[index].uri)
        }
    }

    func searchBarTextChanged(to text: String) {
        if text.count >= 3 {
            updateDishes(searchPredicate: text)
        } else {
            let sortedDishes = sortDishes(initialDishes)
            state = .data(sortedDishes)
        }
    }

    func caloriesSortControlChanged(toState state: SortState) {
        caloriesSortState = state
    }

    func timeSortControlChanged(toState state: SortState) {
        timeSortState = state
    }
}
