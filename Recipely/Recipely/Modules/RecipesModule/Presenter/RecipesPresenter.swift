// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с RecipesPresenter
protocol RecipesPresenterProtocol: AnyObject {}

/// Вью экрана списка рецептов
final class RecipesPresenter: NSObject {
    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinatorProtocol?
    private weak var view: RecipesViewProtocol?
    private var recipes = Recipes()

    // MARK: - Initializers

    init(view: RecipesViewProtocol, coordinator: RecipesCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension RecipesPresenter: RecipesPresenterProtocol {}
