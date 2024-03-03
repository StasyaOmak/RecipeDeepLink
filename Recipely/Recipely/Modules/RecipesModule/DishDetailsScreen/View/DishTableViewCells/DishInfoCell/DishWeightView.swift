// DishWeightView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с информацией о граммовке блюда
final class DishWeightView: UIView {
    // MARK: - Visual Components

    private let potImageView = {
        let view = UIImageView()
        view.image = .potIcon.withTintColor(.systemBackground)
        view.contentMode = .center
        return view
    }()

    private let weightLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(10)
        label.textColor = .systemBackground
        label.textAlignment = .center
        return label
    }()

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 50, height: 50)
    }

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Life Cycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = rect.height / 2
    }

    // MARK: - Public Methods

    func configure(weight: Int) {
        weightLabel.text = "\(weight) " + Metrics.gram.rawValue
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.backgroundColor = UIColor.accent.withAlphaComponent(0.6).cgColor
        layer.cornerCurve = .continuous
        addSubviews(potImageView, weightLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: potImageView, weightLabel)
        potImageViewConfigureLayout()
        weightLabelConfigureLayout()
    }

    private func potImageViewConfigureLayout() {
        [
            potImageView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            potImageView.heightAnchor.constraint(equalToConstant: 17),
            potImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ].activate()
    }

    private func weightLabelConfigureLayout() {
        [
            weightLabel.topAnchor.constraint(equalTo: potImageView.bottomAnchor, constant: 4),
            weightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            weightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ].activate()
    }
}
