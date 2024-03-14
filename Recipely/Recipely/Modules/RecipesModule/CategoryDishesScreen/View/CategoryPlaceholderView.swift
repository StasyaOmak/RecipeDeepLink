// CategoryPlaceholderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения информации что информация в категории не загрузилась
final class CategoryPlaceholderView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let nothingFoundLabelText = "Nothing found"
        static let anotherRequestLabelText = "Try entering your query differently"
    }

    // MARK: - Visual Components

    private let mainImageView = {
        let view = UIImageView()
        view.contentMode = .center
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
        return label
    }()

    private let nothingFoundLabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.text = Constants.nothingFoundLabelText
        return label
    }()

    private let anotherRequestLabel = {
        let label = UILabel()
        label.font = .verdana(size: 14)
        label.textAlignment = .center
        label.textColor = .systemGray2
        label.numberOfLines = 0
        label.text = Constants.anotherRequestLabelText
        return label
    }()

    private let loadingImage = UIImageView()

    // MARK: - Public Properties

    var titleLabelText: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var image: UIImage? {
        get { mainImageView.image }
        set { mainImageView.image = newValue }
    }

    var imageLoading: UIImage? {
        get { loadingImage.image }
        set { loadingImage.image = newValue }
    }

    var reloadText: String? {
        get { reloadLabel.text }
        set { reloadLabel.text = newValue }
    }

    var isHiddenImageButton: Bool {
        get { loadingImage.isHidden }
        set { loadingImage.isHidden = newValue }
    }

    var isHiddenReloadText: Bool {
        get { reloadLabel.isHidden }
        set { reloadLabel.isHidden = newValue }
    }

    var isHiddenBackgroundView: Bool {
        get { backgroundView.isHidden }
        set { backgroundView.isHidden = newValue }
    }

    var isHiddenNothingFoundLabel: Bool {
        get { nothingFoundLabel.isHidden }
        set { nothingFoundLabel.isHidden = newValue }
    }

    var isHiddenAnotherRequestLabel: Bool {
        get { anotherRequestLabel.isHidden }
        set { anotherRequestLabel.isHidden = newValue }
    }

    var isHiddenTitleLabel: Bool {
        get { titleLabel.isHidden }
        set { titleLabel.isHidden = newValue }
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

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(
            backgroundView,
            mainImageView,
            titleLabel,
            reloadLabel,
            loadingImage,
            nothingFoundLabel,
            anotherRequestLabel
        )
    }

    private func configureLayout() {
        UIView.doNotTAMIC(
            for: backgroundView,
            mainImageView,
            titleLabel,
            reloadLabel,
            loadingImage,
            nothingFoundLabel,
            anotherRequestLabel
        )
        configureSavedImageViewLayout()
        configureSavedViewLayout()
        configureMainMessageLabelLayout()
        configureReloadLabelLayout()
        configureLoadingButtonLayout()
        configureNothingFoundLabelLayout()
        configureAnotherRequestLabelLayout()
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
            reloadLabel.leadingAnchor.constraint(equalTo: loadingImage.trailingAnchor, constant: 9),
            reloadLabel.widthAnchor.constraint(equalToConstant: 60),
            reloadLabel.heightAnchor.constraint(equalToConstant: 24)
        ].activate()
    }

    private func configureLoadingButtonLayout() {
        [
            loadingImage.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 9),
            loadingImage.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 41),
            loadingImage.widthAnchor.constraint(equalToConstant: 14),
            loadingImage.heightAnchor.constraint(equalTo: loadingImage.widthAnchor)
        ].activate()
    }

    private func configureNothingFoundLabelLayout() {
        [
            nothingFoundLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 17),
            nothingFoundLabel.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            nothingFoundLabel.widthAnchor.constraint(equalToConstant: 350),
            nothingFoundLabel.heightAnchor.constraint(equalToConstant: 20)
        ].activate()
    }

    private func configureAnotherRequestLabelLayout() {
        [
            anotherRequestLabel.topAnchor.constraint(equalTo: nothingFoundLabel.bottomAnchor, constant: 25),
            anotherRequestLabel.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            anotherRequestLabel.widthAnchor.constraint(equalToConstant: 350),
            anotherRequestLabel.heightAnchor.constraint(equalToConstant: 16)
        ].activate()
    }
}
