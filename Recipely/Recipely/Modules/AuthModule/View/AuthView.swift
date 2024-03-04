// AuthView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с AuthView
protocol AuthViewProtocol: AnyObject {
    // функция для проверки на валидность email
    func setEmailFieldStateTo(_ state: AuthView.AuthTextFieldState)
    // функция для проверки на валидность password
    func setPasswordFieldStateTo(_ state: AuthView.AuthTextFieldState)
    // функция для проверки запуска активити индикатора
    func startIndicator()
    // функция для проверки остановки активити индикатора
    func stopIndicator()
    // функция для отображения предупреждений об ошибке при авторизации
    func showWarning()
}

/// Вью экрана аутентификаци
final class AuthView: UIViewController {
    // MARK: - Types

    enum AuthTextFieldState {
        case plain
        case highlited
    }

    // MARK: - Constants

    enum Constants {
        static let gridient = "gridient"
        static let loginText = "Login"
        static let passwordText = "Password"
        static let emailAddressText = "Email Address"
        static let emailPlaceholder = "Enter Email Address"
        static let enterPassword = "Enter Password"
        static let passwordWarningText = "You entered the wrong password"
        static let emailWarningText = "Incorrect format"
        static let loginWarningText = "Please check the accuracy of the entered credentials."
    }

    // MARK: - Visual Components

    private var loginButtonBottomAnchor: NSLayoutConstraint?

    private lazy var loginButton = {
        let button = LoginButton()
        button.setTitle(Constants.loginText, for: .normal)
        button.addTarget(self, action: #selector(
            loginButtonTapped
        ), for: .touchUpInside)
        return button
    }()

    private lazy var hideOpenPasswordButton = {
        let button = UIButton()
        button.setImage(.crossedEyeIcon, for: .normal)
        return button
    }()

    private lazy var deletingTextdButton = {
        let button = UIButton()
        button.setImage(.crossInCircleIcon, for: .normal)
        return button
    }()

    private lazy var emailTextField = {
        let text = UITextField()
        text.textColor = .black
        text.textAlignment = .left
        text.keyboardType = .default
        text.font = .verdana(size: 18)
        text.placeholder = Constants.emailPlaceholder
        text.addTarget(self, action: #selector(emailChanged(_:)), for: .editingChanged)
        return text
    }()

    private let loginLabel = {
        let label = UILabel()
        label.text = Constants.loginText
        label.font = .verdanaBold(size: 28)
        label.textColor = .textAccent
        return label
    }()

    private let emailAddressLabel = {
        let label = UILabel()
        label.text = Constants.emailAddressText
        label.font = .verdanaBold(size: 18)
        label.textColor = .textAccent
        return label
    }()

    private let addressView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        return view
    }()

    private let envelopeIconImageView = {
        let image = UIImageView()
        image.image = .envelopeIcon
        return image
    }()

    private let passwordLabel = {
        let label = UILabel()
        label.text = Constants.passwordText
        label.font = .verdana(size: 18)
        label.textColor = .textAccent
        return label
    }()

    private let passwordTextField = {
        let text = UITextField()
        text.placeholder = Constants.enterPassword
        text.textAlignment = .left
        text.font = .verdana(size: 18)
        text.textColor = .black
        text.keyboardType = .default
        return text
    }()

    private let passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        return view
    }()

    private let loginView: UIView = {
        let view = UIView()
        view.backgroundColor = .warnings
        view.layer.cornerRadius = 12
        view.alpha = 0
        return view
    }()

    private let lockIconImageView = {
        let image = UIImageView()
        image.image = UIImage.lockIcon
        return image
    }()

    private let warningsPasswordLabel = {
        let label = UILabel()
        label.text = Constants.passwordWarningText
        label.font = .verdanaBold(size: 12)
        label.textColor = UIColor.warnings
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    private let warningsEmailLabel = {
        let label = UILabel()
        label.text = Constants.emailWarningText
        label.font = .verdanaBold(size: 12)
        label.textColor = UIColor.warnings
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    private let warningsAccuracyLabel = {
        let label = UILabel()
        label.text = Constants.loginWarningText
        label.font = .verdana(size: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()

    private let gradient = CAGradientLayer()

    // MARK: - Public Properties

    var presenter: AuthPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubview()
        setupConstaints()
    }

    // MARK: - Private Methods

    private func addSubview() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )

        let subviews = [
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
            warningsEmailLabel,
            deletingTextdButton,
            loginView,
            warningsAccuracyLabel
        ]
        view.layer.addSublayer(gradient)
        view.addSubviews(subviews)
        view.addGestureRecognizer(tapGesture)
        UIView.doNotTAMIC(for: subviews)
    }

    private func setupUI() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(kbWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(kbWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor.gradient.cgColor
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
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            hideOpenPasswordButton.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -14),
            hideOpenPasswordButton.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 17),
            hideOpenPasswordButton.heightAnchor.constraint(equalToConstant: 19),
            hideOpenPasswordButton.widthAnchor.constraint(equalToConstant: 22),

            deletingTextdButton.trailingAnchor.constraint(equalTo: addressView.trailingAnchor, constant: -15),
            deletingTextdButton.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 15),
            deletingTextdButton.heightAnchor.constraint(equalToConstant: 20),
            deletingTextdButton.widthAnchor.constraint(equalToConstant: 20)

        ])
        loginButtonBottomAnchor = loginButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -37
        )
        loginButtonBottomAnchor?.activate()
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
            warningsEmailLabel.widthAnchor.constraint(equalToConstant: 230),

            warningsAccuracyLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 15),
            warningsAccuracyLabel.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 16),
            warningsAccuracyLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -34),
            warningsAccuracyLabel.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -17),
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
            passwordView.heightAnchor.constraint(equalToConstant: 50),

            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: -10),
            loginView.heightAnchor.constraint(equalToConstant: 87),
        ])
    }

    @objc private func loginButtonTapped() {
        presenter?.loginButtonTapped(withPassword: passwordTextField.text)
    }

    @objc private func kbWillShow(_ notification: Notification) {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue
        )?.cgRectValue {
            UIView.animate(withDuration: 0.5) {
                self.loginButtonBottomAnchor?.constant = -(keyboardSize.height)
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func kbWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.5) {
            self.loginButtonBottomAnchor?.constant = -37
            self.view.layoutIfNeeded()
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func emailChanged(_ sender: UITextField) {
        presenter?.emailTextFieldValueChanged(to: sender.text)
    }
}

extension AuthView: AuthViewProtocol {
    func showWarning() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.warningsAccuracyLabel.alpha = 1
            self.loginView.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 2, options: .curveLinear) {
                self.warningsAccuracyLabel.alpha = 0
                self.loginView.alpha = 0
            }
        }
    }

    func stopIndicator() {
        loginButton.stopIndicator()
        presenter?.didEndSpinningSpinner()
    }

    func startIndicator() {
        loginButton.startIndicator()
    }

    func setEmailFieldStateTo(_ state: AuthTextFieldState) {
        switch state {
        case .plain:
            warningsEmailLabel.isHidden = true
            emailAddressLabel.textColor = .textAccent
            addressView.layer.borderColor = UIColor.opaqueSeparator.cgColor

        case .highlited:
            warningsEmailLabel.isHidden = false
            emailAddressLabel.textColor = .red
            addressView.layer.borderColor = UIColor.warnings.cgColor
        }
    }

    func setPasswordFieldStateTo(_ state: AuthTextFieldState) {
        switch state {
        case .plain:
            warningsPasswordLabel.isHidden = true
            passwordLabel.textColor = .textAccent
            passwordView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        case .highlited:
            warningsPasswordLabel.isHidden = false
            passwordLabel.textColor = .red
            passwordView.layer.borderColor = UIColor.warnings.cgColor
        }
    }
}
