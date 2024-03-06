// TermsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с заголовком и текстом
final class TermsView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Terms of Use"
        static let termsText = """
        Welcome to our recipe app! We're thrilled to have you on board.
        To ensure a delightful experience for everyone, please take a moment to familiarize yourself with our rules:
        User Accounts:
        Maintain one account per user.
        Safeguard your login credentials; don't share them with others.
        Content Usage:
        Recipes and content are for personal use only.
        Do not redistribute or republish recipes without proper attribution.
        Respect Copyright:
        Honor the copyright of recipe authors and contributors.
        Credit the original source when adapting or modifying a recipe.
        Community Guidelines:
        Show respect in community features.
        Avoid offensive language or content that violates community standards.
        Feedback and Reviews:
        Share constructive feedback and reviews.
        Do not submit false or misleading information.
        Data Privacy:
        Review and understand our privacy policy regarding data collection and usage.
        Compliance with Laws:
        Use the app in compliance with all applicable laws and regulations.
        Updates to Terms:
        Stay informed about updates; we'll notify you of any changes.
        By using our recipe app, you agree to adhere to these rules.
        Thank you for being a part of our culinary community! Enjoy exploring and cooking up a storm!
        """
    }

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
        label.text = Constants.titleText
        return label
    }()

    private let termsTextView = {
        let view = UITextView()
        view.textColor = .label
        view.font = .verdana(size: 14)
        view.isEditable = false
        view.textAlignment = .left
        view.showsVerticalScrollIndicator = false
        view.text = Constants.termsText
        return view
    }()

    private let closeButton = {
        let button = UIButton()
        button.setImage(.closeIcon.withTintColor(.label), for: .normal)
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
