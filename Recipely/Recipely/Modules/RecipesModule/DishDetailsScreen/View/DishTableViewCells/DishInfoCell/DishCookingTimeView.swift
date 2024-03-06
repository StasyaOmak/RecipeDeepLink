// DishCookingTimeView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с информацией о времени приготовления блюда
final class DishCookingTimeView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let cookingTimeText = "Cooking time"
    }

    // MARK: - Visual Components

    private let timerImageView = {
        let view = UIImageView()
        view.image = .timerIcon.withTintColor(.systemBackground)
        return view
    }()

    private let timerLabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 125, height: 50)
    }

    // MARK: - Private Properties

    private lazy var timerLabelStyle = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineSpacing = 4
        return style
    }()

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

    func configure(cookingTime time: Int) {
        let text = Constants.cookingTimeText + "\n\(time) " + Metrics.minutes.rawValue
        timerLabel.attributedText = text.attributed()
            .withParagraphStyle(timerLabelStyle)
            .withColor(.systemBackground)
            .withFont(.verdana(size: 10))
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.backgroundColor = UIColor.accent.withAlphaComponent(0.6).cgColor
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        layer.cornerCurve = .continuous
        addSubviews(timerImageView, timerLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: timerImageView, timerLabel)
        timerImageViewConfigureLayout()
        timerLabelConfigureLayout()
    }

    private func timerImageViewConfigureLayout() {
        [
            timerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            timerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            timerImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            timerImageView.heightAnchor.constraint(equalTo: timerImageView.widthAnchor)
        ].activate()
    }

    private func timerLabelConfigureLayout() {
        [
            timerLabel.leadingAnchor.constraint(equalTo: timerImageView.trailingAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ].activate()
    }
}
