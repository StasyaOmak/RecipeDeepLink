// FavouritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс иньекции зависимостей в FavouritesPresenter
protocol FavouritesPresenterProtocol: AnyObject {
    /// Добавляет координатор экрана списка сохраненных рецептов в качесте зависимости
    /// - Parameter coordinator: Координатор экрана списка сохраненных рецептов
    func injectCoordinator(_ coordinator: FavouritesCoordinatorProtocol)
}

/// Интерфейс общения с FavouritesPresenter
protocol FavouritesPresenterInput: AnyObject {}

/// Вью экрана списка сохраненных рецептов
final class FavouritesPresenter {
    // MARK: - Public Properties

    weak var view: FavouritesView?

    // MARK: - Private Properties

    private weak var coordinator: FavouritesCoordinatorProtocol?
    private var favourites = Favourites()
}

extension FavouritesPresenter: FavouritesPresenterInput {}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    func injectCoordinator(_ coordinator: FavouritesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
