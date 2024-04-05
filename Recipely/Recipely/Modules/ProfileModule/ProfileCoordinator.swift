// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с ProfileCoordinator
protocol ProfileCoordinatorProtocol: AnyObject {
    /// Презентует экран программы лояльности
    func showLoyaltyProgramScreen()
    /// Презентует экран правил использования
    func showTermsOfUseScreen()
    /// Презентует экран с картой и онформацией о партнерах
    func showPartnersScreen()
    /// Сообщает о том, что надо закрыть экран правил использования
    func didEndTermsOfUseScreen()
    /// Презентует екран с детальной информацией по локации
    func showLocationDetailScreen(locationInfo: MapLocation, completion: @escaping VoidHandler)

    /// Дисмисит контроллер с верха стека контроллеров
    func dismissLastController()
    /// Сообщает о необходимости завершить текущий модуль
    func endProfileModule()
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
        let profileScreen = builder.buildProfileScreen(coordinator: self)
        rootController.setViewControllers([profileScreen], animated: false)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func showLoyaltyProgramScreen() {
        let loyaltyProgramController = builder.buildLoyaltyProgramScreen(coordinator: self)
        rootController.present(loyaltyProgramController, animated: true)
    }

    func showTermsOfUseScreen() {
        let view = builder.buildTermsOfUseScreen(coordinator: self)
        view.modalPresentationStyle = .overFullScreen
        rootController.present(view, animated: true)
    }

    func didEndTermsOfUseScreen() {
        rootController.presentedViewController?.dismiss(animated: false)
    }

    func showPartnersScreen() {
        let view = builder.buildPartnersScreen(coordinator: self)
        view.modalPresentationStyle = .fullScreen
        rootController.present(view, animated: true)
    }

    func showLocationDetailScreen(locationInfo: MapLocation, completion: @escaping VoidHandler) {
        let view = builder.buildLocationDetailScreen(
            coordinator: self,
            locationInfo: locationInfo,
            completion: completion
        )
        rootController.visibleViewController?.present(view, animated: true)
    }

    func dismissLastController() {
        rootController.presentedViewController?.dismiss(animated: true)
    }

    func endProfileModule() {
        parentCoordinator?.childDidFinish(self)
    }
}
