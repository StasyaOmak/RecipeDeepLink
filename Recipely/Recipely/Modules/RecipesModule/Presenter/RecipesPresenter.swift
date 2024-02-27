// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс иньекции зависимостей в RecipesPresenter
protocol RecipesPresenterProtocol: AnyObject {
    /// Добавляет координатор экрана списка рецептов в качесте зависимости
    /// - Parameter coordinator: Координатор экрана списка рецептов
    func injectCoordinator(_ coordinator: RecipesCoordinatorProtocol)
}

/// Интерфейс общения с RecipesPresenter
protocol RecipesPresenterInput: AnyObject {}

/// Вью экрана списка рецептов
final class RecipesPresenter: NSObject {
    // MARK: - Public Properties

    weak var view: RecipesViewInput?

    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinatorProtocol?
    private var user = User()
}

extension RecipesPresenter: RecipesPresenterInput {}

extension RecipesPresenter: RecipesPresenterProtocol {
    func injectCoordinator(_ coordinator: RecipesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
