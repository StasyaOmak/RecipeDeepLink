// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с RecipesCoordinator
protocol RecipesCoordinatorProtocol: AnyObject {
    /// Презентует экран с блюдами из выбранной категории
    func showCategoryScreen()
}

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
        let recipesScreen = builder.categoryScreen()
        rootController.setViewControllers([recipesScreen], animated: false)
    }
}

extension RecipesCoordinator: RecipesCoordinatorProtocol {
    func showCategoryScreen() {}
}
