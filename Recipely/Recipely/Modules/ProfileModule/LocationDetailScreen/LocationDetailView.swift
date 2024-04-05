// LocationDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol LocationDetailViewProtocol: AnyObject {
    /// Конфигурирует экран в соответствии с переданными параметрами
    func configure(with location: MapLocation)
}

final class LocationDetailView: UIViewController {
    // MARK: - Visual Components

    private let titleLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .verdanaBold(size: 20)
        label.textColor = .textAccent
        label.textAlignment = .center
        return label
    }()

    private let addressLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .verdana(size: 20)
        label.textColor = .textAccent
        label.textAlignment = .center
        return label
    }()

    private let discountLabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .verdana(size: 16)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let promocodeLabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    private lazy var closeButton = {
        let button = UIButton()
        let image = AssetImage.Icons.closeIcon.image.withTintColor(.label, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel, discountLabel, promocodeLabel])
        stack.axis = .vertical
        stack.setCustomSpacing(8, after: titleLabel)
        stack.setCustomSpacing(43, after: addressLabel)
        stack.setCustomSpacing(26, after: discountLabel)
        return stack
    }()

    // MARK: - Private Properties

    var presenter: LocationDetailPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        presenter?.viewLoaded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(closeButton, stackView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: closeButton, stackView)
        closeButtonConfigureLayout()
        stackViewConfigureLayout()
    }

    private func closeButtonConfigureLayout() {
        [
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 23),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        ].activate()
    }

    private func stackViewConfigureLayout() {
        [
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 49),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ].activate()
    }

    @objc private func closeButtonTapped() {
        presenter?.closeButtonTapped()
    }
}

extension LocationDetailView: LocationDetailViewProtocol {
    func configure(with location: MapLocation) {
        titleLabel.text = location.partner.name
        addressLabel.text = location.address
        discountLabel.text = Local.LocationDetailView.discountText + location.partner.discount.description + "%"
        let promocodeText = Local.LocationDetailView.promocodeText
            .attributed()
            .withFont(.verdana(size: 16))
            .withColor(.label)
        promocodeText.append(
            location.partner.promocode
                .attributed()
                .withFont(.verdanaBold(size: 16))
                .withColor(.label)
        )
        promocodeLabel.attributedText = promocodeText
    }
}
