// PartnersView.swift
// Copyright © RoadMap. All rights reserved.

import GoogleMaps
import UIKit

/// Интерфейс взаимодействия с PartnersView
protocol PartnersViewProtocol: AnyObject {
    /// Задает начальное положение камеры
    func setCamera(_ camera: GMSCameraPosition)
    /// Расставляет маркеры на указанных позациях
    func createMarkers(atCoordinates coordinates: [CLLocationCoordinate2D])
    /// Переводит камеру к указанной координате
    func gotToCoordinate(_ coordinate: CLLocationCoordinate2D)
    /// Передвигает пользовательский маркер к указанной координате
    func updateManualMarkerCoordinate(_ coordinate: CLLocationCoordinate2D)
    /// Убирает выделение с текущей выбранной точки
    func deselectCurrentMarker()
}

/// Вью экрана правил использования
final class PartnersView: UIViewController {
    // MARK: - Visual Components

    private let navigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.titleTextAttributes = [
            .font: UIFont.verdanaBold(size: 20) ?? UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.label
        ]
        navigationBar.barTintColor = .systemBackground
        navigationBar.shadowImage = UIImage()
        return navigationBar
    }()

    private let captionLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .verdana(size: 18)
        label.textColor = .label
        label.text = Local.PartnersView.captionText
        return label
    }()

    private lazy var mapView = {
        let map = GMSMapView()
        map.delegate = self
        return map
    }()

    private lazy var locationButton = {
        let button = UIButton()
        button.layer.cornerRadius = 26
        button.backgroundColor = .systemBackground
        button.setImage(AssetImage.Icons.locationIcon.image.withTintColor(.label), for: .normal)
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var okActionButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.layer.cornerRadius = 12
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .verdanaBold(size: 16)
        button.setTitle(Local.PartnersView.okText, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var presenter: PartnersPresenterProtocol?

    // MARK: - Private Properties

    private lazy var manualMarker = {
        let marker = GMSMarker()
        marker.icon = AssetImage.Icons.currentLocationPinIcon.image
        return marker
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        presenter?.viewLoaded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("something")
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        view.addSubviews(navigationBar, mapView, locationButton, captionLabel, okActionButton)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: navigationBar, mapView, locationButton, captionLabel, okActionButton)
        navigationBarConfigureLayout()
        mapViewConfigureLayout()
        locationButtonConfigureLayout()
        captionLabelConfigureLayout()
        okActionButtonConfigureLayout()
    }

    private func navigationBarConfigureLayout() {
        [
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].activate()
    }

    private func mapViewConfigureLayout() {
        [
            mapView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ].activate()
    }

    private func locationButtonConfigureLayout() {
        [
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            locationButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -14),
            locationButton.heightAnchor.constraint(equalToConstant: 52),
            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor)
        ].activate()
    }

    private func captionLabelConfigureLayout() {
        [
            captionLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 40),
            captionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            captionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ].activate()
    }

    private func okActionButtonConfigureLayout() {
        [
            okActionButton.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 60),
            okActionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -53),
            okActionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okActionButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            okActionButton.heightAnchor.constraint(equalToConstant: 48)
        ].activate()
    }

    private func configureNavigationBar() {
        let navigationItem = UINavigationItem(title: Local.PartnersView.titleText)
        navigationBar.items = [navigationItem]
        let closeButton = UIBarButtonItem(
            image: AssetImage.Icons.closeIcon.image.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        navigationItem.rightBarButtonItem = closeButton
    }

    @objc private func closeButtonTapped() {
        presenter?.closeButtonTapped()
    }

    @objc private func locationButtonTapped() {
        presenter?.locationButtonTapped()
        guard let presenter else { return }
        let locationAsset = presenter.isTrackingUserLocation
            ? AssetImage.Icons.filledLocationIcon
            : AssetImage.Icons.locationIcon
        locationButton.setImage(locationAsset.image, for: .normal)
    }
}

extension PartnersView: PartnersViewProtocol {
    func setCamera(_ camera: GMSCameraPosition) {
        mapView.animate(to: camera)
        mapView.camera = camera
    }

    func createMarkers(atCoordinates coordinates: [CLLocationCoordinate2D]) {
        for coordinate in coordinates {
            let marker = GMSMarker(position: coordinate)
            marker.icon = AssetImage.Icons.locationPinIcon.image
            marker.map = mapView
        }
    }

    func gotToCoordinate(_ coordinate: CLLocationCoordinate2D) {
        mapView.animate(toLocation: coordinate)
    }

    func updateManualMarkerCoordinate(_ coordinate: CLLocationCoordinate2D) {
        if manualMarker.map == nil {
            manualMarker.map = mapView
        }
        manualMarker.position = coordinate
    }

    func deselectCurrentMarker() {
        mapView.selectedMarker?.icon = AssetImage.Icons.locationPinIcon.image
    }
}

extension PartnersView: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        presenter?.didTapAtCoordinate(coordinate)
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        marker.icon = AssetImage.Icons.currentLocationPinIcon.image
        presenter?.didTapMarkerAtCoordinate(marker.position)
        return true
    }
}
