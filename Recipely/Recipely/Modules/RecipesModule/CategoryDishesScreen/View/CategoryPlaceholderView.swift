// CategoryPlaceholderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения информации что информация в категории не загрузилась
final class CategoryPlaceholderView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let mainMessageText = "Failed to load data"
        static let reloadText = "Reload"
    }

    // MARK: - Visual Components

    private let mainImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "lightning")?
            .withAlignmentRectInsets(UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20))
//        let imageInsets = UIEdgeInsets(top: -13, left: 13, bottom: 0, right: 0)
//        view.image = UIImage(named: "lightning")?
//            .resizableImage(withCapInsets: imageInsets, resizingMode: .stretch)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .backgroundPlaceholder
        return view
    }()

    private let titleLabel = {
        let label = UILabel()
        label.font = .verdana(size: 14)
        label.textAlignment = .center
        label.textColor = .systemGray2
        label.text = Constants.mainMessageText
        return label
    }()

    private let backgroundView = {
        let view = UIView()
        view.backgroundColor = UIColor.searhBar
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .backgroundPlaceholder
        return view
    }()

    private let reloadLabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.text = Constants.reloadText
        return label
    }()

    private let loadingButton = {
        let button = UIButton()
        button.setImage(.mistake, for: .normal)
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
        addSubviews(backgroundView, mainImageView, titleLabel, reloadLabel, loadingButton)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: backgroundView, mainImageView, titleLabel, reloadLabel, loadingButton)
        configureSavedImageViewLayout()
        configureSavedViewLayout()
        configureMainMessageLabelLayout()
        configureReloadLabelLayout()
        configureLoadingButtonLayout()
    }

    private func configureSavedImageViewLayout() {
        [
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 50),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor)
        ].activate()
    }

    private func configureMainMessageLabelLayout() {
        [
            titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 17),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 16)
        ].activate()
    }

    private func configureSavedViewLayout() {
        [
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 150),
            backgroundView.heightAnchor.constraint(equalToConstant: 32),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ].activate()
    }

    private func configureReloadLabelLayout() {
        [
            reloadLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 4),
            reloadLabel.leadingAnchor.constraint(equalTo: loadingButton.trailingAnchor, constant: 9),
            reloadLabel.widthAnchor.constraint(equalToConstant: 60),
            reloadLabel.heightAnchor.constraint(equalToConstant: 24)
        ].activate()
    }

    private func configureLoadingButtonLayout() {
        [
            loadingButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 9),
            loadingButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 41),
            loadingButton.widthAnchor.constraint(equalToConstant: 14),
            loadingButton.heightAnchor.constraint(equalTo: loadingButton.widthAnchor)
        ].activate()
    }
}
