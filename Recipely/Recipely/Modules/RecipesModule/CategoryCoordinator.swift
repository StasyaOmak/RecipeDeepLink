// CategoryCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с CategoryCoordinator
protocol CategoryCoordinatorProtocol: AnyObject {}

/// Координатор модуля категорий рецептов
final class CategoryCoordinator: BaseCoordinator {
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
        let categoryScreen = builder.categoryScreen(coordinator: self)
        rootController.setViewControllers([categoryScreen], animated: false)
    }
}

extension CategoryCoordinator: CategoryCoordinatorProtocol {}
