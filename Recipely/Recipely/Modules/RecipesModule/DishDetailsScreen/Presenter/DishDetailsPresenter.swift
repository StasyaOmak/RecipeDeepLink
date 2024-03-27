// DishDetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с DishDetailsPresenter
protocol DishDetailsPresenterProtocol {
    /// Состояние загрузки
    var state: ViewState<Dish> { get }
    /// Просит обновить данные по блюду
    func requestDishUpdate()
    /// Получить данные изображения для ячейки по индексу
    func getDishImage(completion: @escaping (Data) -> ())
    /// Сообщает о нажатии на кнопку поделиться
    func shareButtonTapped()
    /// Сообщает о нажатии на кнопку добавления в избранное
    func addToFavouritesButtonTapped()
}

/// Презентер экрана детального описания блюда
final class DishDetailsPresenter {
    // MARK: - Constants

    private enum Constants {
        static let userSharedRecipeLogMessage = "Пользователь поделился рецептом "
    }

    private weak var view: DishDetailsViewProtocol?
    private weak var coordinator: RecipesCoordinatorProtocol?
    private weak var networkService: NetworkServiceProtocol?
    private weak var imageLoadService: ImageLoadServiceProtocol?
    private weak var coreDataService: CoreDataServiceProtocol?

    private var uri: String
    private(set) var state: ViewState<Dish> = .loading {
        didSet {
            DispatchQueue.main.async {
                self.view?.updateState()
            }
        }
    }

    // MARK: - Initializers

    init(
        view: DishDetailsViewProtocol?,
        coordinator: RecipesCoordinatorProtocol?,
        networkService: NetworkServiceProtocol?,
        imageLoadService: ImageLoadServiceProtocol?,
        coreDataService: CoreDataServiceProtocol?,
        uri: String
    ) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        self.imageLoadService = imageLoadService
        self.coreDataService = coreDataService
        self.uri = uri
        addDishListener()
    }

    // MARK: - Life Cycle

    deinit {
        coreDataService?.removeListener(for: self)
    }

    // MARK: - Private Methods

    private func addDishListener() {
        coreDataService?.addDishListener(for: self) { [weak self] updatedDish in
            guard case let .data(dish) = self?.state,
                  dish.uri == updatedDish.uri
            else { return }
            self?.state = .data(updatedDish)
        }
    }

    private func updateDish() {
        state = .loading
        networkService?.getDish(byURI: uri) { [weak self] result in
            switch result {
            case var .success(dish):
                self?.coreDataService?.isDishFavourite(dish) { isFavourite in
                    dish.isFavourite = isFavourite
                    self?.state = .data(dish)
                }
            case let .failure(error):
                self?.state = .error(error)
            }
        }
    }
}

extension DishDetailsPresenter: DishDetailsPresenterProtocol {
    func requestDishUpdate() {
        updateDish()
    }

    func getDishImage(completion: @escaping (Data) -> ()) {
        guard case let .data(dish) = state,
              let url = URL(string: dish.linkToImage)
        else { return }
        imageLoadService?.loadImage(atURL: url) { data, _, _ in
            if let data {
                completion(data)
            }
        }
    }

    func shareButtonTapped() {
        if case let .data(dish) = state {
            LogAction.log(Constants.userSharedRecipeLogMessage + dish.name)
        }
    }

    func addToFavouritesButtonTapped() {
        guard case var .data(dish) = state else { return }
        dish.isFavourite.toggle()
        coreDataService?.updateIsFavouriteStatus(forDish: dish)
    }
}
