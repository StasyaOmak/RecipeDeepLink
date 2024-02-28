// RecipelyCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координато приложения
final class RecipelyCoordinator: BaseCoordinator {
    // MARK: - Private Properties

    private var builder: Builder

    // MARK: - Visual Components

    private var window: UIWindow?

    // MARK: - Initializers

    init(window: UIWindow?, builder: Builder) {
        self.window = window
        self.builder = builder
    }

    // MARK: - Public Methods

    override func start() {
        let tabBarController = builder.buildRecipelyTabBarController()
        let tabBarCoordinator = RecipelyTabBarCoordinator(rootController: tabBarController, builder: builder)
        add(coordinator: tabBarCoordinator)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        tabBarCoordinator.start()
    }

//    override func start() {
//        let tabBarController = builder.buildAuthScreen()
//        window?.rootViewController = tabBarController
//        window?.makeKeyAndVisible()
//    }
}
