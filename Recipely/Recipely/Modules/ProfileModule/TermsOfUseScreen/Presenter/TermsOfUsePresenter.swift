// TermsOfUsePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с TermsOfUsePresenter
protocol TermsOfUsePresenterProtocol: AnyObject {
    /// Сообщает о том, что вью покинула пределы экрана
    func viewDisappearedUnderScreen()
}

/// Презентер экрана правил использования
final class TermsOfUsePresenter {
    // MARK: - Private Properties

    private weak var coordinator: ProfileCoordinatorProtocol?
    private weak var view: TermsOfUseViewProtocol?

    // MARK: - Initializers

    init(view: TermsOfUseViewProtocol, coordinator: ProfileCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Life Cycle

    deinit {
        print("deinit ", String(describing: self))
    }
}

extension TermsOfUsePresenter: TermsOfUsePresenterProtocol {
    func viewDisappearedUnderScreen() {
        coordinator?.didEndTermsOfUseScreen()
    }
}
