// LoyaltyProgramPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс иньекции зависимостей в LoyaltyProgramPresenter
protocol LoyaltyProgramPresenterProtocol: AnyObject {
    /// Добавляет координатор пофиля пользователя в качесте зависимости
    func injectCoordinator(_ coordinator: ProfileCoordinatorProtocol)
}

/// Интерфейс общения с LoyaltyProgramPresenter
protocol LoyaltyProgramPresenterInput: AnyObject {
    func viewLoaded()
    func closeButtonTapped()
}

/// Вью экрана списка рецептов
final class LoyaltyProgramPresenter: NSObject {
    // MARK: - Public Properties

    weak var view: LoyaltyProgramViewInput?

    // MARK: - Private Properties

    private weak var coordinator: ProfileCoordinatorProtocol?
    private var loyaltyProgram = LoyaltyProgram(bonucesAmount: 100)
}

extension LoyaltyProgramPresenter: LoyaltyProgramPresenterInput {
    func viewLoaded() {
        view?.updateBonucesAnountLabel(with: "\(loyaltyProgram.bonucesAmount)")
    }

    func closeButtonTapped() {
        view?.dismiss()
    }
}

extension LoyaltyProgramPresenter: LoyaltyProgramPresenterProtocol {
    func injectCoordinator(_ coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
