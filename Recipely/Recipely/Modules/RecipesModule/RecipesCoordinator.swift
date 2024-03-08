// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с RecipesCoordinator
protocol RecipesCoordinatorProtocol: AnyObject {
    /// Презентует экран со списком блюд выбранной категории
    func showCategoryDishesScreen(withTitle title: String)
    /// Презентует экран с детальным писанием блюда
    func showDishDetailsScreen(dish: Dish)
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
        let view = builder.buildCategoriesScreen(coordinator: self)
        rootController.setViewControllers([view], animated: false)
    }
}

extension RecipesCoordinator: RecipesCoordinatorProtocol {
    func showCategoryDishesScreen(withTitle title: String) {
        let view = builder.buildCategoryDishesScreen(coordinator: self, title: title)
        rootController.pushViewController(view, animated: true)
    }

    func showDishDetailsScreen(dish: Dish) {
        let view = builder.buildDishDetailsScreen(coordinator: self, dish: dish)
        rootController.pushViewController(view, animated: true)
    }
}
