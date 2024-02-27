// RecipesPresenter copy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RecipesPresenterProtocol: AnyObject {
    func injectCoordinator(_ coordinator: RecipesCoordinatorProtocol)
}

protocol RecipesPresenterInput: AnyObject {}

final class RecipesPresenter: NSObject {
    // MARK: - Public Properties

    private weak var coordinator: RecipesCoordinatorProtocol?
    weak var view: RecipesViewInput?
    var profile = Recipes()
}

extension RecipesPresenter: RecipesPresenterInput {}

extension RecipesPresenter: RecipesPresenterProtocol {
    func injectCoordinator(_ coordinator: RecipesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
