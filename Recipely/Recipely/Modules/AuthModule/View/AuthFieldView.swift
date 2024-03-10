// AuthFieldView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Вью для отображения поля ввода аутентификационных данных пользователя
class AuthFieldView: UIView {
    // MARK: - Types

    enum AuthTextFieldState {
        case plain
        case highlited
    }

    // MARK: - Visual Components

    private let leftAccessoryImageView = {
        let image = UIImageView()
        image.image = UIImage.lockIcon
        image.contentMode = .center
        return image
    }()

    private let titleLabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 18)
        label.textColor = .textAccent
        return label
    }()

    private let warningsLabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 12)
        label.textColor = UIColor.warnings
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    private let backgroundView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.backgroundColor = .systemBackground
        view.layer.borderColor = UIColor.opaqueSeparator.cgColor
        return view
    }()

    private lazy var textField = {
        let text = UITextField()
        text.textColor = .black
        text.textAlignment = .left
        text.keyboardType = .default
        text.font = .verdana(size: 18)
        return text
    }()

    private lazy var rightAccessoryButton = {
        let button = UIButton()
        return button
    }()

    // MARK: - Public Properties

    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }

    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    var leftAccessoryImage: UIImage? {
        get { leftAccessoryImageView.image }
        set { leftAccessoryImageView.image = newValue }
    }

    var rightAccessoryButtonImage: UIImage? {
        get { rightAccessoryButton.image(for: .normal) }
        set { rightAccessoryButton.setImage(newValue, for: .normal) }
    }

    var warningsText: String? {
        get { warningsLabel.text }
        set { warningsLabel.text = newValue }
    }

    var isRightButtonHidden: Bool {
        get { rightAccessoryButton.isHidden }
        set { rightAccessoryButton.isHidden = newValue }
    }

    var mainLabel: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    // MARK: - Initializers

    init(selectorMethod: Selector?, view: AuthView?) {
        super.init(frame: .zero)
        configureUI()
        configureLayout()
        guard let selectorMethod else { return }
        textField.addTarget(view, action: selectorMethod, for: .editingChanged)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        let subviews = [
            backgroundView,
            rightAccessoryButton,
            textField,
            titleLabel,
            leftAccessoryImageView,
            warningsLabel
        ]
        addSubviews(subviews)
        UIView.doNotTAMIC(for: subviews)
    }

    private func configureLayout() {
        configureTitleLabelLayout()
        configureTextFieldLayout()
        configureTextFieldImageViewLayout()
        configureTextFieldIButtonLayout()
        configureTextFieldViewLayout()
        configureWarningsLabelLayout()
    }

    private func configureTitleLabelLayout() {
        [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.widthAnchor.constraint(equalToConstant: 200)
        ].activate()
    }

    private func configureTextFieldLayout() {
        [
            textField.leadingAnchor.constraint(equalTo: leftAccessoryImageView.trailingAnchor, constant: 13),
            textField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 14),
            textField.heightAnchor.constraint(equalToConstant: 24),
            textField.widthAnchor.constraint(equalToConstant: 255)
        ].activate()
    }

    private func configureTextFieldImageViewLayout() {
        [
            leftAccessoryImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 17),
            leftAccessoryImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 18),
            leftAccessoryImageView.heightAnchor.constraint(equalToConstant: 16),
            leftAccessoryImageView.widthAnchor.constraint(equalToConstant: 20),
        ].activate()
    }

    private func configureTextFieldIButtonLayout() {
        [
            rightAccessoryButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15),
            rightAccessoryButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 15),
            rightAccessoryButton.heightAnchor.constraint(equalToConstant: 20),
            rightAccessoryButton.widthAnchor.constraint(equalToConstant: 20)
        ].activate()
    }

    private func configureTextFieldViewLayout() {
        [
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            backgroundView.heightAnchor.constraint(equalToConstant: 50)
        ].activate()
    }

    private func configureWarningsLabelLayout() {
        [
            warningsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            warningsLabel.widthAnchor.constraint(equalToConstant: 230),
            warningsLabel.heightAnchor.constraint(equalToConstant: 19),
            warningsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].activate()
    }

    // MARK: - Public Methods

    func setTextFieldStateTo(_ state: AuthTextFieldState) {
        switch state {
        case .plain:
            warningsLabel.isHidden = true
            titleLabel.textColor = .textAccent
            backgroundView.layer.borderColor = UIColor.opaqueSeparator.cgColor

        case .highlited:
            warningsLabel.isHidden = false
            titleLabel.textColor = .warnings
            backgroundView.layer.borderColor = UIColor.warnings.cgColor
        }
    }
}
