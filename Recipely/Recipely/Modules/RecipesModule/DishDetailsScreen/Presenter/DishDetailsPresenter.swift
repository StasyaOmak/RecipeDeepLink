// DishDetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с DishDetailsPresenter
protocol DishDetailsPresenterProtocol {
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
    private weak var coordinator: RecipesCoordinatorProtocol?
    private var dish: Dish {
        didSet {
//            view?.updateFavouritesButtonState(to: dish.isFavourite)
        }
    }

    // MARK: - Initializers

    init(view: DishDetailsViewProtocol, coordinator: RecipesCoordinatorProtocol, dish: Dish) {
        self.view = view
        self.coordinator = coordinator
        self.dish = dish
//        addDishListener()
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
}

extension DishDetailsPresenter: DishDetailsPresenterProtocol {
    func viewBeganLoading() {
        view?.configure(with: dish)
    }

    func shareButtonTapped() {
        LogAction.log(Constants.userSharedRecipeLogMessage + dish.name)
    }

    func addToFavouritesButtonTapped() {}
}
