// LoyaltyProgramView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с BonucesView
protocol LoyaltyProgramViewProtocol: AnyObject {
    /// Обновляет лейбл количества бонусных баллов пользователя.
    func updateBonucesAnountLabel(with text: String)
    /// Закрывает LoyaltyProgramView
    func dismiss()
}

/// Вью экрана количества бонусов
final class LoyaltyProgramView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Your bonuses"
    }

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 20)
        label.textColor = .textAccent
        label.text = Constants.titleText
        label.textAlignment = .center
        return label
    }()

    private let bonucesImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = .bonuces
        return view
    }()

    private let starImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        let iconColor = #colorLiteral(red: 0.9490196078, green: 0.7882352941, blue: 0.2980392157, alpha: 1)
        view.image = .starIcon.withTintColor(iconColor, renderingMode: .alwaysOriginal)
        return view
    }()

    private let bonucesAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 30)
        label.textColor = .textAccent
        label.textAlignment = .left
        return label
    }()

    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.setImage(.closeIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(didTapExitButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var presenter: LoyaltyProgramPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        presenter?.viewLoaded()
    }
    
    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, bonucesImageView, starImageView, bonucesAmountLabel, exitButton)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: titleLabel, bonucesImageView, starImageView, bonucesAmountLabel, exitButton)
        configureExitButtonLayout()
        configureTitleLabelViewLayout()
        configureUserImageViewLayout()
        configureStarImageViewLayout()
        configureBonucesAmountLabelLayout()
    }

    private func configureExitButtonLayout() {
        [
            exitButton.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -2),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exitButton.heightAnchor.constraint(equalToConstant: 24),
            exitButton.widthAnchor.constraint(equalTo: exitButton.heightAnchor)
        ].activate()
    }

    private func configureTitleLabelViewLayout() {
        [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ].activate()
    }

    private func configureUserImageViewLayout() {
        [
            bonucesImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            bonucesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bonucesImageView.heightAnchor.constraint(equalToConstant: 136),
        ].activate()
    }

    private func configureStarImageViewLayout() {
        [
            starImageView.topAnchor.constraint(equalTo: bonucesImageView.bottomAnchor, constant: 31),
            starImageView.leadingAnchor.constraint(equalTo: bonucesImageView.leadingAnchor, constant: 20),
            starImageView.heightAnchor.constraint(equalToConstant: 28),
            starImageView.widthAnchor.constraint(equalTo: starImageView.heightAnchor)
        ].activate()
    }

    private func configureBonucesAmountLabelLayout() {
        [
            bonucesAmountLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 14),
            bonucesAmountLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            bonucesAmountLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -73)
        ].activate()
    }

    @objc private func didTapExitButton() {
        presenter?.closeButtonTapped()
    }
}

extension LoyaltyProgramView: LoyaltyProgramViewProtocol {
    func updateBonucesAnountLabel(with text: String) {
        bonucesAmountLabel.text = text
    }

    func dismiss() {
        dismiss(animated: true)
    }
}
