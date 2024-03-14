// DishDetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с DishDetailsPresenter
protocol DishDetailsPresenterProtocol {
    /// Состояние загрузки
    var state: ViewState<Dish> { get }
    /// Сообщает о том, что вью начала свой жизненный цикл
    func viewBeganLoading()
    /// Сообщает о назатии на кнопку поделиться
    func shareButtonTapped()
    /// Сообщает онажатии на кнопку добавления в любимые блюда
    func addToFavouritesButtonTapped()
}

/// Презентер экрана детального описания блюда
final class DishDetailsPresenter {
    // MARK: - Private Properties

    // MARK: - Constants

    private enum Constants {
        static let userSharedRecipeLogMessage = "Пользователь поделился рецептом "
    }

    private weak var view: DishDetailsViewProtocol?
    private var uri: String
    private weak var coordinator: RecipesCoordinatorProtocol?
    private let networkService = NetworkService()
//    private var dish: Dish {
//        didSet {
    ////            view?.updateFavouritesButtonState(to: dish.isFavourite)
//        }
//    }

    var state: ViewState<Dish> = .loading {
        didSet {
            view?.updateState()
        }
    }

    // MARK: - Initializers

    init(view: DishDetailsViewProtocol, coordinator: RecipesCoordinatorProtocol, uri: String) {
        self.view = view
        self.coordinator = coordinator
        self.uri = uri
        updateRecipe()
    }

    // MARK: - Life Cycle

    deinit {
//        DishesService.shared.removeListener(for: self)
    }

    // MARK: - Private Methods

//    private func addDishListener() {
//        DishesService.shared.addDishListener(for: self) { [weak self] updatedDish in
//            self?.dish = updatedDish
//        }
//    }

    private func updateRecipe() {
        networkService.getDish(byURI: uri) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(recipe):
                    self?.state = .data(recipe)
                case let .failure(error):
                    self?.state = .error(error)
                }
            }
        }
    }
}

extension DishDetailsPresenter: DishDetailsPresenterProtocol {
    func viewBeganLoading() {
//        view?.configure(with: dish)
    }

    func shareButtonTapped() {
//        LogAction.log(Constants.userSharedRecipeLogMessage + dish.name)
    }

    func addToFavouritesButtonTapped() {}
}
