// SortingControlView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения контроля сорттировок
class SortingControlView: UIView {
    // MARK: - Visual Components

    private let controlImageView = {
        let image = UIImageView()
        image.image = .stackBlack
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let nameControlLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(16)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        configureView()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureView() {
        backgroundColor = .recipeView
        layer.cornerRadius = 20
        addSubviews(controlImageView, nameControlLabel)

        UIView.doNotTAMIC(for: controlImageView, nameControlLabel)
    }

    func changeParameters(title: String, image: UIImage) {
        controlImageView.image = image
        nameControlLabel.text = title
    }

    private func configureLayout() {
        [
            nameControlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameControlLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            controlImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            controlImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            controlImageView.widthAnchor.constraint(equalToConstant: 16),
            controlImageView.heightAnchor.constraint(equalToConstant: 16)
        ].activate()
    }
}
