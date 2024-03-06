// RecipelyTabBarCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор главного экрана приложения с таббаром
final class RecipelyTabBarCoordinator: BaseCoordinator {
    // MARK: - Visual Components

    private var rootController: RecipelyTabBarController

    // MARK: - Private Properties

    private var builder: Builder

    // MARK: - Initializers

    init(rootController: RecipelyTabBarController, builder: Builder) {
        self.rootController = rootController
        self.builder = builder
    }

    // MARK: - Public Methods

    override func start() {
        let recipesRootController = UINavigationController()
        let favouritesRootController = UINavigationController()
        let profileRootController = UINavigationController()

        let recipesCoordinator = RecipesCoordinator(rootController: recipesRootController, builder: builder)
        let favouritesCoordinator = FavouritesCoordinator(rootController: favouritesRootController, builder: builder)
        let profileCoordinator = ProfileCoordinator(rootController: profileRootController, builder: builder)

        rootController.setViewControllers(
            [recipesRootController, favouritesRootController, profileRootController],
            animated: false
        )

        add(coordinator: favouritesCoordinator)
        add(coordinator: recipesCoordinator)
        add(coordinator: profileCoordinator)

        profileCoordinator.start()
        recipesCoordinator.start()
        favouritesCoordinator.start()
    }

    override func childDidFinish(_ child: Coordinator) {
        if child is ProfileCoordinator {
            parentCoordinator?.childDidFinish(self)
        }
    }
}
