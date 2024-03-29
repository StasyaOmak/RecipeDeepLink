// ReloadButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кнопка перезагрузки данных
final class ReloadButton: UIButton {
    // MARK: - Visual Components

    private let mainImage = {
        let image = UIImageView()
        image.contentMode = .center
        image.image = AssetImage.Icons.reloadIcon.image.withTintColor(
            .placeholderText,
            renderingMode: .alwaysOriginal
        )
        return image
    }()

    private let captionLabel = {
        let label = UILabel()
        label.font = .verdana(size: 14)
        label.textColor = .placeholderText
        label.text = Local.ReloadButton.reloadText
        return label
    }()

    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [mainImage, captionLabel])
        stack.spacing = 9
        return stack
    }()

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 150, height: 32)
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

    // MARK: - Public Methods

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        self
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.cornerRadius = 12
        backgroundColor = .backgroundPlaceholder
        addSubviews(stackView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: stackView)
        [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ].activate()
    }
}
