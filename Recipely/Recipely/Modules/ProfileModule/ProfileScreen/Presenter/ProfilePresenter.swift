// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

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

    /// Обрабатывает нажатие кнопки редактирования имени в профиле.
    func profileEditButtonTapped()
    /// Обрабатывает нажатие на изображения пользователя.
    func profileImageTapped()
    /// Обрабатывает событие подтверждения изменения имени пользователя.
    func didSubmitNewName(_ name: String)
    /// Обрабатывает событие подтверждения изменения имени пользователя.
    func didSubmitNewProfileImage(_ imageData: Data)
    /// Вызывается при подтверждении выхода из профиля пользователя
    func logOutActionTapped()
}

/// Презентер экрана пофиля пользователя
final class ProfilePresenter {
    // MARK: - Private Properties

    private weak var coordinator: ProfileCoordinatorProtocol?
    private weak var view: ProfileViewProtocol?
    private var profile = Profile()
    private let caretaker = Caretaker()

    // MARK: - Initializers

    init(view: ProfileViewProtocol, coordinator: ProfileCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
        caretaker.getMementus()
        caretaker.originator = Originator(imageData: nil, username: nil)
        caretaker.lastState()
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func getSections() -> [ProfileSection] {
        profile.sections
    }

    func getUser() -> User {
        let userName = caretaker.originator?.username ?? profile.user.name
        return User(profileImageData: caretaker.originator?.imageData, name: userName)
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

    func profileImageTapped() {
        view?.showPhotoPicker()
    }

    func didSubmitNewName(_ name: String) {
        caretaker.originator?.username = name
        caretaker.backup()
        caretaker.save()
        view?.updateUserName(with: name)
    }

    func didSubmitNewProfileImage(_ imageData: Data) {
        caretaker.originator?.imageData = imageData
        caretaker.backup()
        caretaker.save()
        view?.updateProfileImage(with: imageData)
    }

    func logOutActionTapped() {
        coordinator?.endProfileModule()
    }
}
