// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с RecipesCoordinator
protocol RecipesCoordinatorProtocol: AnyObject {}

/// Координатор модуля рецептов
final class RecipesCoordinator: BaseCoordinator {
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
        let recipesScreen = builder.buildRecipesScreen(coordinator: self)
        rootController.setViewControllers([recipesScreen], animated: false)
    }
}

extension RecipesCoordinator: RecipesCoordinatorProtocol {}
