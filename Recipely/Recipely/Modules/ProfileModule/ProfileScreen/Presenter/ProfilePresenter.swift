// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с ProfilePresenter
protocol ProfilePresenterProtocol: AnyObject {
    /// Возвращает массив секций профиля для отображения в пользовательском интерфейсе.
    func getSections() -> [ProfileSection]
    /// Возвращает объект пользователя, содержащий информацию о текущем пользователе.
    func getUser() -> User
    /// Возвращает количество подразделов в профиле пользователя.
    func getAmountOfSubSections() -> Int
    /// Возвращает конкретную подсекцию для заданного индекса.
    func getSubSection(forIndex index: Int) -> Setting
    /// Обрабатывает выбор подсекции пользователем.
    func selectedSubSection(atIndex index: Int)
    /// Обрабатывает нажатие кнопки редактирования профиля.
    func profileEditButtonTapped()
    /// Обрабатывает событие подтверждения изменения имени пользователя.
    func didSubmitNewName(_ name: String)
    /// Вызывается при подтверждении выхода из профиля пользователя
    func logOutActionTapped()
}

/// Презентер экрана пофиля пользователя
final class ProfilePresenter {
    // MARK: - Private Properties

    private weak var coordinator: ProfileCoordinatorProtocol?
    private weak var view: ProfileViewProtocol?
    private var profile = Profile()

    // MARK: - Initializers

    init(view: ProfileViewProtocol, coordinator: ProfileCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func getSections() -> [ProfileSection] {
        profile.sections
    }

    func getUser() -> User {
        profile.user
    }

    func getAmountOfSubSections() -> Int {
        profile.settings.count
    }

    func getSubSection(forIndex index: Int) -> Setting {
        profile.settings[index]
    }

    func selectedSubSection(atIndex index: Int) {
        switch profile.settings[index].type {
        case .bonuses:
            coordinator?.showLoyaltyProgramScreen()
        case .termsAndPrivacy:
            coordinator?.showTermsOfUseScreen()
        case .logOut:
            view?.showLogOutMessage()
        }
    }

    func profileEditButtonTapped() {
        view?.showUpdateNameForm()
    }

    func didSubmitNewName(_ name: String) {
        profile.user.name = name
        view?.updateUserNameLabel()
    }

    func logOutActionTapped() {
        coordinator?.endProfileModule()
    }
}
