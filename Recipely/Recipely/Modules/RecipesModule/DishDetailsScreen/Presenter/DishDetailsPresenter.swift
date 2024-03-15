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

    private var uri: String
    private(set) var state: ViewState<Dish> = .loading {
        didSet {
            view?.updateState()
        }
    }

    // MARK: - Initializers

    init(
        view: DishDetailsViewProtocol?,
        coordinator: RecipesCoordinatorProtocol?,
        networkService: NetworkServiceProtocol?,
        imageLoadService: ImageLoadServiceProtocol?,
        uri: String
    ) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        self.imageLoadService = imageLoadService
        self.uri = uri
    }

    // MARK: - Private Methods

    private func updateDish() {
        state = .loading
        networkService?.getDish(byURI: uri) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(dish):
                    self?.state = .data(dish)
                case let .failure(error):
                    self?.state = .error(error)
                }
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
}
