// AuthView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс общения с AuthView
protocol AuthViewInput: AnyObject {
    func setButtonImage(_ image: UIImage)
}

/// Вью экрана аутентификаци
final class AuthView: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let gridient = "gridient"
        static let loginText = "Login"
        static let passwordText = "Password"
        static let verdanaBold = "Verdana-Bold"
        static let verdana = "Verdana"
        static let emailAddressText = "Email Address"
        static let sizeLogin = 16.0
        static let sizeValidatorText = 18.0
        static let loginTitleSize = 28.0
        static let sizeWarningText = 12.0
        static let emailPlaceholder = "Enter Email Address"
        static let enterPassword = "Enter Password"
        static let passwordWarningText = "You entered the wrong password"
        static let emailWarningText = "Incorrect format"
    }

    // MARK: - Visual Components

    private let loginButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle(Constants.loginText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.verdanaBold, size: Constants.sizeLogin)
        button.layer.cornerRadius = 12
        return button
    }()

    private lazy var hideOpenPasswordButton = {
        let button = UIButton()
        button.setImage(.crossedEyeIcon, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    private let loginLabel = {
        let label = UILabel()
        label.text = Constants.loginText
        label.font = UIFont(name: Constants.verdanaBold, size: Constants.loginTitleSize)
        label.textColor = UIColor.authorizationsText
        return label
    }()

    private let emailAddressLabel = {
        let label = UILabel()
        label.text = Constants.emailAddressText
        label.font = UIFont(name: Constants.verdanaBold, size: Constants.sizeValidatorText)
        label.textColor = UIColor.authorizationsText
        return label
    }()

    private let emailTextField = {
        let text = UITextField()
        text.placeholder = Constants.emailPlaceholder
        text.textAlignment = .left
        text.font = UIFont(name: Constants.verdana, size: Constants.sizeValidatorText)
        text.textColor = .black
        return text
    }()

    private let addressView = UIView()

    private let envelopeIconImageView = {
        let image = UIImageView()
        image.image = UIImage.envelopeIcon
        return image
    }()

    private let passwordLabel = {
        let label = UILabel()
        label.text = Constants.passwordText
        label.font = UIFont(name: Constants.verdanaBold, size: Constants.sizeValidatorText)
        label.textColor = UIColor.authorizationsText
        return label
    }()

    private let passwordTextField = {
        let text = UITextField()
        text.placeholder = Constants.enterPassword
        text.textAlignment = .left
        text.font = UIFont(name: Constants.verdana, size: Constants.sizeValidatorText)
        text.textColor = .black
        text.keyboardType = .default
        return text
    }()

    private let passwordView = UIView()

    private let lockIconImageView = {
        let image = UIImageView()
        image.image = UIImage.lockIcon
        return image
    }()

    private let warningsPasswordLabel = {
        let label = UILabel()
        label.text = Constants.passwordWarningText
        label.font = UIFont(name: Constants.verdanaBold, size: Constants.sizeWarningText)
        label.textColor = UIColor.warnings
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    private let warningsEmailLabel = {
        let label = UILabel()
        label.text = Constants.emailWarningText
        label.font = UIFont(name: Constants.verdanaBold, size: Constants.sizeWarningText)
        label.textColor = UIColor.warnings
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    // MARK: - Public Properties

    var presenter: AuthPresenterInput?

    // MARK: - Private Properties

    private let minLenght = 6
    private lazy var regex = "^(?=.*[а-я])(?=.*[А-Я])(?=.*\\d)(?=.*[$@$!%*?&#])[А-Яа-я\\d$@$!%*?&#]{\(minLenght),}$"
    private let gradient = CAGradientLayer()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubview()
        setupConstaints()
    }

    // MARK: - Private Methods

    private func addSubview() {
        view.layer.addSublayer(gradient)

        for item in [
            addressView,
            passwordView,
            loginButton,
            loginLabel,
            emailAddressLabel,
            emailTextField,
            envelopeIconImageView,
            passwordLabel,
            passwordTextField,
            lockIconImageView,
            hideOpenPasswordButton,
            warningsPasswordLabel,
            warningsEmailLabel

        ] {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupUI() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldTextChange),
            name: NSNotification.Name.NSUbiquityIdentityDidChange,
            object: nil
        )
        addressView.backgroundColor = .white
        addressView.layer.cornerRadius = 12
        passwordView.backgroundColor = .white
        passwordView.layer.cornerRadius = 12
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor.gridientWhite.cgColor,
            UIColor.gridient.cgColor
        ]
    }

    private func setupConstaints() {
        setupLabelConstaints()
        setupButtonConstaints()
        setupTextFieldConstaints()
        setupImageConstaints()
        setupViewConstaints()
    }

    private func setupButtonConstaints() {
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            hideOpenPasswordButton.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -14),
            hideOpenPasswordButton.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 17),
            hideOpenPasswordButton.heightAnchor.constraint(equalToConstant: 19),
            hideOpenPasswordButton.widthAnchor.constraint(equalToConstant: 22)

        ])
    }

    private func setupLabelConstaints() {
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 82),
            loginLabel.heightAnchor.constraint(equalToConstant: 32),
            loginLabel.widthAnchor.constraint(equalToConstant: 350),

            emailAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailAddressLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 23),
            emailAddressLabel.heightAnchor.constraint(equalToConstant: 32),
            emailAddressLabel.widthAnchor.constraint(equalToConstant: 200),

            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordLabel.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: 23),
            passwordLabel.heightAnchor.constraint(equalToConstant: 32),
            passwordLabel.widthAnchor.constraint(equalToConstant: 200),

            warningsPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            warningsPasswordLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 1),
            warningsPasswordLabel.heightAnchor.constraint(equalToConstant: 19),
            warningsPasswordLabel.widthAnchor.constraint(equalToConstant: 230),

            warningsEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            warningsEmailLabel.topAnchor.constraint(equalTo: addressView.bottomAnchor),
            warningsEmailLabel.heightAnchor.constraint(equalToConstant: 19),
            warningsEmailLabel.widthAnchor.constraint(equalToConstant: 230)

        ])
    }

    private func setupTextFieldConstaints() {
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: envelopeIconImageView.trailingAnchor, constant: 13),
            emailTextField.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 14),
            emailTextField.heightAnchor.constraint(equalToConstant: 24),
            emailTextField.widthAnchor.constraint(equalToConstant: 255),

            passwordTextField.leadingAnchor.constraint(equalTo: lockIconImageView.trailingAnchor, constant: 15),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 14),
            passwordTextField.heightAnchor.constraint(equalToConstant: 24),
            passwordTextField.widthAnchor.constraint(equalToConstant: 255)

        ])
    }

    private func setupImageConstaints() {
        NSLayoutConstraint.activate([
            envelopeIconImageView.leadingAnchor.constraint(equalTo: addressView.leadingAnchor, constant: 17),
            envelopeIconImageView.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 18),
            envelopeIconImageView.heightAnchor.constraint(equalToConstant: 16),
            envelopeIconImageView.widthAnchor.constraint(equalToConstant: 20),

            lockIconImageView.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 19),
            lockIconImageView.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 14),
            lockIconImageView.heightAnchor.constraint(equalToConstant: 21),
            lockIconImageView.widthAnchor.constraint(equalToConstant: 16)

        ])
    }

    private func setupViewConstaints() {
        NSLayoutConstraint.activate([
            addressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addressView.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 6),
            addressView.heightAnchor.constraint(equalToConstant: 50),

            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 6),
            passwordView.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

    private func checkValidation(password: String) {
        guard password.count >= minLenght else {
            warningsPasswordLabel.text = ""
            return
        }
    }

    func setButtonImage(_ image: UIImage) {
        hideOpenPasswordButton.setImage(image, for: .normal)
    }

    @objc private func buttonTapped() {
        presenter?.buttonTapped()
    }

    @objc private func textFieldTextChange() {}
}

extension AuthView: AuthViewInput {}

//#Preview {
//    let view = RecipesView()
//
//    let presenter = RecipesPresenter()
//    view.presenter = presenter
//    return view
//}
