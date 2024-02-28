// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс иньекции зависимостей в ProfilePresenter
protocol ProfilePresenterProtocol: AnyObject {
    /// Добавляет координатор пофиля пользователя в качесте зависимости
    func injectCoordinator(_ coordinator: ProfileCoordinatorProtocol)
}

/// Интерфейс общения с ProfilePresenter
protocol ProfilePresenterInput: AnyObject {
    func getUser() -> User
    func getAmountOfSettings() -> Int
    func getSetting(forIndex index: Int) -> Setting
    func selectedSettingCell(atIndex index: Int)
    func profileEditButtonTapped()
    func didSubmitNewName(_ name: String)
}

/// Вью экрана пофиля пользователя
final class ProfilePresenter {
    // MARK: - Public Properties

    weak var view: ProfileView?

    // MARK: - Private Properties

    private weak var coordinator: ProfileCoordinatorProtocol?
    private var profile = Profile()
}

extension ProfilePresenter: ProfilePresenterInput {
    func getUser() -> User {
        profile.user
    }

    func getAmountOfSettings() -> Int {
        profile.settings.count
    }

    func getSetting(forIndex index: Int) -> Setting {
        profile.settings[index]
    }

    func selectedSettingCell(atIndex index: Int) {
        switch profile.settings[index].type {
        case .bonuses:
            coordinator?.showLoyaltyProgramScreen()
        case .termsAndPrivacy:
            view?.presentCurrentlyUnderDevelopmentAlert()
        case .logOut:
            view?.presentLogOutAlert()
        }
    }

    func profileEditButtonTapped() {
        view?.presentNameChangeAlert()
    }

    func didSubmitNewName(_ name: String) {
        profile.user.name = name
        view?.reloadFirstRow()
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func injectCoordinator(_ coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
