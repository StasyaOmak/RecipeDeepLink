// LocationDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol LocationDetailPresenterProtocol: AnyObject {
    /// Сообщает от том, что view загрузилась
    func viewLoaded()
    /// Сообщает от том, что view собирается закрыться
    func viewWillDisappear()
    /// Сообщает о нажании на кнопку закрытия экрана
    func closeButtonTapped()
}

final class LocationDetailPresenter {
    // MARK: - Private Properties

    private weak var view: LocationDetailViewProtocol?
    private weak var coordinator: ProfileCoordinatorProtocol?
    private let locationInfo: MapLocation
    private let completion: VoidHandler

    // MARK: - Initializers

    init(
        view: LocationDetailViewProtocol,
        coordinator: ProfileCoordinatorProtocol,
        locationInfo: MapLocation,
        completion: @escaping VoidHandler
    ) {
        self.view = view
        self.coordinator = coordinator
        self.locationInfo = locationInfo
        self.completion = completion
    }
}

extension LocationDetailPresenter: LocationDetailPresenterProtocol {
    func viewLoaded() {
        view?.configure(with: locationInfo)
    }

    func viewWillDisappear() {
        completion()
    }

    func closeButtonTapped() {
        coordinator?.dismissLastController()
    }
}
