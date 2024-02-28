// AuthCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с AuthCoordinator
protocol AuthCoordinatorProtocol: AnyObject {}

/// Координатор экрана аутентификации пользователя
final class AuthCoordinator: BaseCoordinator {
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
        let authScreen = builder.buildAuthScreen(coordinator: self)
        rootController.setViewControllers([authScreen], animated: false)
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {}
