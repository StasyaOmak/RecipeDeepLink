// PartnersPresenter.swift
// Copyright © RoadMap. All rights reserved.

import CoreLocation
import Foundation
import GoogleMaps

/// Интерфейс взаимодействия с PartnersPresenter
protocol PartnersPresenterProtocol: AnyObject {
    /// Флаг о том, происходит ли сейчас отслеживание локации пльзователя
    var isTrackingUserLocation: Bool { get }

    /// Сообщает от том, что view загрузилась
    func viewLoaded()
    /// Сообщает о нажании на кнопку закрытия экрана
    func closeButtonTapped()
    /// Сообщает о нажатии на кнопку возвращения к текущей локации
    func locationButtonTapped()
    /// Сообщает о нажании на кнопку Ok
    func okButtonTapped()
    /// Сообщает от тапе пользователя по карте
    func didTapAtCoordinate(_ coordinate: CLLocationCoordinate2D)
    /// Сообщает о нажатии пользователя по пину на карте
    func didTapMarkerAtCoordinate(_ coordinate: CLLocationCoordinate2D)
}

/// Презентер экрана правил использования
final class PartnersPresenter: NSObject {
    // MARK: - Private Properties

    private weak var coordinator: ProfileCoordinatorProtocol?
    private weak var view: PartnersViewProtocol?

    private var geocoder = CLGeocoder()
    private lazy var locationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()

    private var camera: GMSCameraPosition?
    private(set) var isTrackingUserLocation = false
    private let locations: [MapLocation] = {
        do {
            guard let locationsUrl = Bundle.main.url(forResource: "partners", withExtension: "json") else { return [] }
            let data = try Data(contentsOf: locationsUrl)
            let locations = try JSONDecoder().decode([MapLocation].self, from: data)
            return locations
        } catch {
            return []
        }
    }()

    // MARK: - Initializers

    init(view: PartnersViewProtocol, coordinator: ProfileCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }

    deinit {
        locationManager.stopUpdatingLocation()
    }
}

extension PartnersPresenter: PartnersPresenterProtocol {
    func viewLoaded() {
        locationManager.requestLocation()
        let coordinates = locations.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
        view?.createMarkers(atCoordinates: coordinates)
    }

    func closeButtonTapped() {
        coordinator?.dismissLastController()
    }

    func locationButtonTapped() {
        if !isTrackingUserLocation {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
        isTrackingUserLocation.toggle()
    }

    func okButtonTapped() {
        coordinator?.dismissLastController()
    }

    func didTapAtCoordinate(_ coordinate: CLLocationCoordinate2D) {
        view?.updateManualMarkerCoordinate(coordinate)
    }

    func didTapMarkerAtCoordinate(_ coordinate: CLLocationCoordinate2D) {
        guard var targetLocation = locations.filter({
            $0.latitude == coordinate.latitude && $0.longitude == coordinate.longitude
        }).first else { return }
        view?.gotToCoordinate(coordinate)

        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] places, _ in
            guard let place = places?.first else { return }
            targetLocation.address = place.name
            self?.coordinator?.showLocationDetailScreen(locationInfo: targetLocation, completion: {
                self?.view?.deselectCurrentMarker()
            })
        }
    }
}

extension PartnersPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        if camera == nil {
            camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 13)
            guard let camera else { return }
            view?.setCamera(camera)
        } else {
            view?.gotToCoordinate(location.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {}
}
