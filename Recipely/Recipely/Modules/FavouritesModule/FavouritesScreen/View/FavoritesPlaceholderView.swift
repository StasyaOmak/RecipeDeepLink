// FavoritesPlaceholderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения информации что в избранное ничего не добавили
final class FavoritesPlaceholderView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let mainMessageText = "There's nothing here yet"
        static let supportiveMessageText = "Add interesting recipes to make ordering products \nconvenient"
    }

    // MARK: - Visual Components

    private let mainImageView = {
        let image = UIImageView()
        image.image = .saved
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let savedView = {
        let view = UIView()
        view.backgroundColor = UIColor.searhBar
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.layer.cornerCurve = .continuous
        return view
    }()

    private let titleLabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.text = Constants.mainMessageText
        return label
    }()

    private let messageLabel = {
        let label = UILabel()
        label.font = .verdana(size: 12.5)
        label.textAlignment = .center
        label.textColor = .systemGray2
        label.text = Constants.supportiveMessageText
        label.numberOfLines = 0
        return label
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
        addSubviews(savedView, mainImageView, titleLabel, messageLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: savedView, mainImageView, titleLabel, messageLabel)
        configureSavedImageViewLayout()
        configureSavedViewLayout()
        configureMainMessageLabelLayout()
        configureSupportiveMessageLabelLayout()
    }

    private func configureSavedImageViewLayout() {
        [
            mainImageView.centerYAnchor.constraint(equalTo: savedView.centerYAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: savedView.centerXAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 24),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor)
        ].activate()
    }

    private func configureSavedViewLayout() {
        [
            savedView.heightAnchor.constraint(equalToConstant: 50),
            savedView.widthAnchor.constraint(equalTo: savedView.heightAnchor),
            savedView.topAnchor.constraint(equalTo: topAnchor),
            savedView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ].activate()
    }

    private func configureMainMessageLabelLayout() {
        [
            titleLabel.topAnchor.constraint(equalTo: savedView.bottomAnchor, constant: 17),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ].activate()
    }

    private func configureSupportiveMessageLabelLayout() {
        [
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 32)
        ].activate()
    }
}
