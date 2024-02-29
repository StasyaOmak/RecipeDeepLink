// LoyaltyProgramPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с LoyaltyProgramPresenter
protocol LoyaltyProgramPresenterProtocol: AnyObject {
    /// Сообщает презентеру, что view было загружено.
    func viewLoaded()
    /// Обрабатывает событие нажатия на кнопку закрытия LoyaltyProgramView.
    func closeButtonTapped()
}

/// Вью экрана списка рецептов
final class LoyaltyProgramPresenter: NSObject {
    // MARK: - Private Properties

    private weak var view: LoyaltyProgramViewProtocol?
    private weak var coordinator: ProfileCoordinatorProtocol?
    private var loyaltyProgram = LoyaltyProgram(bonucesAmount: 100)

    // MARK: - Initializers

    init(view: LoyaltyProgramViewProtocol, coordinator: ProfileCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension LoyaltyProgramPresenter: LoyaltyProgramPresenterProtocol {
    func viewLoaded() {
        view?.updateBonucesAnountLabel(with: "\(loyaltyProgram.bonucesAmount)")
    }

    func closeButtonTapped() {
        view?.dismiss()
    }
}
