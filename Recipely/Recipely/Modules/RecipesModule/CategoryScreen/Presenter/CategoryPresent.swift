// CategoryPresent.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с CategoryPresenter
protocol CategoryPresenterProtocol {}

/// Вью экрана категории рецептов
final class CategoryPresenter {
    // MARK: - Private Properties

    private weak var coordinator: CategoryCoordinatorProtocol?
    private weak var view: CategoryViewProtocol?

    // MARK: - Initializers

    init(view: CategoryViewProtocol, coordinator: CategoryCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension CategoryPresenter: CategoryPresenterProtocol {}
