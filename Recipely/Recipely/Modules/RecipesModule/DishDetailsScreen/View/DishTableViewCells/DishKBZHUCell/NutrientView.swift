// NutrientView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с информацией об одном значении из КБЖУ блюда
final class NutrientView: UIView {
    // MARK: - Visual Components

    private let captionLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(10)
        label.textColor = .systemBackground
        label.textAlignment = .center
        label.backgroundColor = .accent
        return label
    }()

    private let valueLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(10)
        label.textColor = .accent
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        return label
    }()

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 74, height: 53)
    }

    // MARK: - Private Properties

    private var metrics: Metrics

    // MARK: - Initializers

    init(metrics: Metrics) {
        self.metrics = metrics
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        metrics = .gram
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func configure(title: String, value: Float) {
        captionLabel.text = title
        valueLabel.text = value.cleanValue + " " + metrics.rawValue
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.accent.cgColor
        layer.cornerCurve = .continuous
        layer.frame = layer.frame.insetBy(dx: 2, dy: 2)
        clipsToBounds = true
        addSubviews(captionLabel, valueLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: captionLabel, valueLabel)
        valueLabelConfigureLayout()
        captionLabelConfigureLayout()
    }

    private func valueLabelConfigureLayout() {
        [
            captionLabel.topAnchor.constraint(equalTo: topAnchor),
            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            captionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            captionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.58)
        ].activate()
    }

    private func captionLabelConfigureLayout() {
        [
            valueLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 3),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ].activate()
    }
}
