// TermsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с заголовком и текстом
final class TermsView: UIView {
    // MARK: - Visual Components

    private let grabberView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        view.layer.cornerRadius = 2.5
        return view
    }()

    private let titleLabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 20)
        label.textColor = .label
        label.textAlignment = .left
        label.text = Local.TermsView.titleText
        return label
    }()

    private let termsTextView = {
        let view = UITextView()
        view.textColor = .label
        view.font = .verdana(size: 14)
        view.isEditable = false
        view.textAlignment = .left
        view.showsVerticalScrollIndicator = false
        view.text = Local.TermsView.termsText
        return view
    }()

    private let closeButton = {
        let button = UIButton()
        button.setImage(AssetImage.Icons.closeIcon.image.withTintColor(.label), for: .normal)
        return button
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

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .systemBackground
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true
        addSubviews(grabberView, closeButton, titleLabel, termsTextView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: grabberView, closeButton, titleLabel, termsTextView)
        grabberViewConfigureLayout()
        closeButtonConfigureLayout()
        titleLabelConfigureLayout()
        termsTextViewConfigureLayout()
    }

    private func grabberViewConfigureLayout() {
        [
            grabberView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            grabberView.centerXAnchor.constraint(equalTo: centerXAnchor),
            grabberView.heightAnchor.constraint(equalToConstant: 5),
            grabberView.widthAnchor.constraint(equalToConstant: 50)
        ].activate()
    }

    private func closeButtonConfigureLayout() {
        [
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        ].activate()
    }

    private func titleLabelConfigureLayout() {
        [
            titleLabel.topAnchor.constraint(equalTo: grabberView.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ].activate()
    }

    private func termsTextViewConfigureLayout() {
        [
            termsTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            termsTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            termsTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            termsTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ].activate()
    }
}
