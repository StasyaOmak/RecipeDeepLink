// Coordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс стандартного координатора
protocol Coordinator: AnyObject {
    /// Массив дочерних координаторов
    var childCoordinators: [Coordinator] { get set }
    /// Метод запуска координатора
    func start()
}

extension Coordinator {
    /// Добавление переданного координатора в массив дочерних координаторов
    /// - Parameter coordinator: Координатор который требуется добавить
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    /// Удаление переданного координатора из массива дочерних координаторов
    /// - Parameter coordinator: Координатор который требуется удалить
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
