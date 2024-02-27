// FavouritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс общения с FavouritesCoordinator
protocol FavouritesCoordinatorProtocol: AnyObject {}

/// Координатор модуля любимых рецептов
final class FavouritesCoordinator: BaseCoordinator {
    // MARK: - Visual Components

    private var rootController: UINavigationController

    // MARK: - Private Properties

    private var builder: Builder

    // MARK: - Initializers

    init(rootController: UINavigationController, builder: Builder) {
        self.rootController = rootController
        self.builder = builder
    }

    // MARK: - Public Methods

    override func start() {
        let favouritesScreen = builder.buildFavouritesScreen()
        (favouritesScreen.presenter as? FavouritesPresenterProtocol)?.injectCoordinator(self)
        rootController.setViewControllers([favouritesScreen], animated: false)
    }
}

extension FavouritesCoordinator: FavouritesCoordinatorProtocol {}
