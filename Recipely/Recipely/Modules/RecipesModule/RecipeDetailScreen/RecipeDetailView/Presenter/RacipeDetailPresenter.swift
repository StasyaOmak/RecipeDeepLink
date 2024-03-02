// RacipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с RecipeDetailPresenter
protocol RecipeDetailPresenterProtocol {
    /// Сообщает о том, что вью начала ской жизненный цикл
    func viewBeganLoading()
}

/// Презентер экрана детального описания блюда
final class RecipeDetailPresenter {
    // MARK: - Private Properties

    private weak var view: RecipeDetailViewProtocol?
    private weak var coordinator: RecipesCoordinatorProtocol?
    private var dish = Dish.fishAndCorn

    // MARK: - Initializers

    init(view: RecipeDetailViewProtocol, coordinator: RecipesCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    func viewBeganLoading() {
        view?.configure(with: dish)
    }
}
