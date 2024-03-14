// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с RecipesCoordinator
protocol RecipesCoordinatorProtocol: AnyObject {
    /// Презентует экран со списком блюд выбранной категории
    func showCategoryDishesScreen(withCategory category: DishCategory)
    /// Презентует экран с детальным писанием блюда
    func showDishDetailsScreen(with dish: Dish)
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
    func showCategoryDishesScreen(withCategory category: DishCategory) {
        let view = builder.buildCategoryDishesScreen(coordinator: self, category: category)
        rootController.pushViewController(view, animated: true)
    }

    func showDishDetailsScreen(with dish: Dish) {
        let view = builder.buildDishDetailsScreen(coordinator: self, dish: dish)
        rootController.pushViewController(view, animated: true)
    }
}
