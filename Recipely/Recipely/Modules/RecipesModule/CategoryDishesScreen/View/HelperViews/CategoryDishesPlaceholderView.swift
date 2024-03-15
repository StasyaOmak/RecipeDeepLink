// CategoryDishesPlaceholderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения  дополнительной информации по состоянию загрузки данных
final class CategoryDishesPlaceholderView: UIView {
    // MARK: - Constants

    /// Состояние вью
    enum State {
        /// Показывает информацию что данных нет
        case nothingFound
        /// Показывает информацию об ошибке
        case error
        /// Вью спрятано
        case hidden
    }

    private enum Constants {
        static let nothingFoundText = "Nothing found"
        static let failedToLoadText = "Failed to load data"
        static let tryEnteringQueryText = "Try entering your query differently"
    }

    // MARK: - Visual Components

    private let mainImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.layer.cornerRadius = 12
        view.backgroundColor = .backgroundPlaceholder
        return view
    }()

    private let titleLabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 18)
        label.textAlignment = .center
        label.textColor = .label
        label.text = Constants.nothingFoundText
        return label
    }()

    private let captionLabel = {
        let label = UILabel()
        label.font = .verdana(size: 14)
        label.textAlignment = .center
        label.textColor = .placeholderText
        return label
    }()

    private let reloadButton = ReloadButton()

    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, captionLabel, reloadButton])
        stack.axis = .vertical
        stack.spacing = 17
        return stack
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

    // MARK: - Public Methods

    func switchToState(_ state: State) {
        switch state {
        case .nothingFound:
            isHidden = false
            mainImageView.image = .magnifier
            captionLabel.text = Constants.tryEnteringQueryText
            titleLabel.isHidden = false
            reloadButton.isHidden = true
        case .error:
            isHidden = false
            mainImageView.image = .mistake
            captionLabel.text = Constants.failedToLoadText
            titleLabel.isHidden = true
            reloadButton.isHidden = false
        case .hidden:
            isHidden = true
        }
    }

    func addTarget(_ target: Any?, action: Selector) {
        reloadButton.addTarget(target, action: action, for: .touchUpInside)
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(mainImageView, stackView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: mainImageView, stackView)
        mainImageViewConfigureLayout()
        stackViewConfigureLayout()
    }

    private func mainImageViewConfigureLayout() {
        [
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 50),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor)
        ].activate()
    }

    private func stackViewConfigureLayout() {
        [
            stackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 17),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ].activate()
    }
}
