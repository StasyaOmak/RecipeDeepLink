// DishDetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с DishDetailsPresenter
protocol DishDetailsPresenterProtocol {
    /// Сообщает о том, что вью начала свой жизненный цикл
    func viewBeganLoading()
    /// Сообщает о назатии на кнопку поделиться
    func didTapShareButton()
}

/// Презентер экрана детального описания блюда
final class DishDetailsPresenter {
    // MARK: - Private Properties

    private weak var view: DishDetailsViewProtocol?
    private weak var coordinator: RecipesCoordinatorProtocol?
    private var dish: Dish

    // MARK: - Initializers

    init(view: DishDetailsViewProtocol, coordinator: RecipesCoordinatorProtocol, dish: Dish) {
        self.view = view
        self.coordinator = coordinator
        self.dish = dish
    }
}

extension DishDetailsPresenter: DishDetailsPresenterProtocol {
    func viewBeganLoading() {
        view?.configure(with: dish)
//        view?.addRecipe
        
    }

    func didTapShareButton() {
        LogAction.log("Пользователь поделился рецептом \(dish.name)")
    }
}
