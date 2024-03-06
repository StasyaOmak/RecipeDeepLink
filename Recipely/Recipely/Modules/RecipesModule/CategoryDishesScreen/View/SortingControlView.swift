// SortingControlView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения контрола сортировок
class SortingControlView: UIView {
    // MARK: - Visual Components

    private let controlImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let nameControlLabel = {
        let label = UILabel()
        label.font = .verdana(size: 16)
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

    // MARK: - Public Methods

    func changeParameters(title: String, image: UIImage) {
        controlImageView.image = image
        nameControlLabel.text = title
    }

    // MARK: - Private Methods

    private func configureView() {
        backgroundColor = .recipeView
        layer.cornerRadius = 18
        addSubviews(controlImageView, nameControlLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: controlImageView, nameControlLabel)
        [
            nameControlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameControlLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            controlImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            controlImageView.leadingAnchor.constraint(equalTo: nameControlLabel.trailingAnchor, constant: 4),
            controlImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            controlImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            controlImageView.heightAnchor.constraint(equalToConstant: 16),
            controlImageView.widthAnchor.constraint(equalTo: controlImageView.heightAnchor)
        ].activate()
    }
}
