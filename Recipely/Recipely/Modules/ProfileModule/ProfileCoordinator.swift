// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс общения с ProfileCoordinator
protocol ProfileCoordinatorProtocol: AnyObject {
    func showLoyaltyProgramScreen()
}

/// Координатор модуля профиля пользователя
final class ProfileCoordinator: BaseCoordinator {
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
        let profileScreen = builder.buildProfileScreen()
        (profileScreen.presenter as? ProfilePresenterProtocol)?.injectCoordinator(self)
        rootController.setViewControllers([profileScreen], animated: false)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func showLoyaltyProgramScreen() {
        let loyaltyProgramController = builder.buildLoyaltyProgramScreen()
        (loyaltyProgramController.presenter as? LoyaltyProgramPresenter)?.injectCoordinator(self)
        rootController.present(loyaltyProgramController, animated: true)
    }
}
