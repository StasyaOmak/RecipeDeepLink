// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Абстрактный класс координатора
class BaseCoordinator: Coordinator {
    // MARK: - Public Properties

    var childCoordinators: [Coordinator] = []

    // MARK: - Public Methods

    func start() {
        fatalError("Child should implement funcStart")
    }
}
