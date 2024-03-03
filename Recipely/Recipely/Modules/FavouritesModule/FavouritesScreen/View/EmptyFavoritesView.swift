// EmptyFavoritesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения информации что в избранное ничего не добавили
final class EmptyFavoritesView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let mainMessageText = "There's nothing here yet"
        static let supportiveMessageText = "Add interesting recipes to make ordering products \nconvenient"
    }

    // MARK: - Visual Components

    private let savedImageView = {
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

    private let mainMessageLabel = {
        let label = UILabel()
        label.font = .verdanaBold?.withSize(18)
        label.textAlignment = .center
        label.textColor = .black
        label.text = Constants.mainMessageText
        return label
    }()

    private let supportiveMessageLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(12.5)
        label.textAlignment = .center
        label.textColor = .systemGray2
        label.text = Constants.supportiveMessageText
        label.numberOfLines = 0
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
        addSubviews(savedView, savedImageView, mainMessageLabel, supportiveMessageLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: savedView, savedImageView, mainMessageLabel, supportiveMessageLabel)
        configureSavedImageViewLayout()
        configureSavedViewLayout()
        configureMainMessageLabelLayout()
        configureSupportiveMessageLabelLayout()
    }

    private func configureSavedImageViewLayout() {
        [
            savedImageView.centerYAnchor.constraint(equalTo: savedView.centerYAnchor),
            savedImageView.centerXAnchor.constraint(equalTo: savedView.centerXAnchor),
            savedImageView.heightAnchor.constraint(equalToConstant: 24),
            savedImageView.widthAnchor.constraint(equalTo: savedImageView.heightAnchor)
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
            mainMessageLabel.topAnchor.constraint(equalTo: savedView.bottomAnchor, constant: 17),
            mainMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ].activate()
    }

    private func configureSupportiveMessageLabelLayout() {
        [
            supportiveMessageLabel.topAnchor.constraint(equalTo: mainMessageLabel.bottomAnchor, constant: 17),
            supportiveMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            supportiveMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            supportiveMessageLabel.heightAnchor.constraint(equalToConstant: 32)
        ].activate()
    }
}
