// AuthView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс общения с AuthView
protocol AuthViewInput: AnyObject {
    func setButtonImage(_ image: UIImage)
    func showInputEmail
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

    private lazy var loginButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle(Constants.loginText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.verdanaBold, size: Constants.sizeLogin)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(
            clickLoginButton
        ), for: .touchUpInside)
        return button
    }()

    private lazy var hideOpenPasswordButton = {
        let button = UIButton()
        button.setImage(.crossedEyeIcon, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var deletingTextdButton = {
        let button = UIButton()
        button.setImage(.crossInCircleIcon, for: .normal)
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
        text.keyboardType = .default
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

    private lazy var tap = UITapGestureRecognizer(
        target: self,
        action: #selector(UIInputViewController.dismissKeyboard)
    )

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
//        passwordTextField.delegate = self
        emailTextField.delegate = self
        view.addGestureRecognizer(tap)
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
            warningsEmailLabel,
            deletingTextdButton

        ] {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
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
            hideOpenPasswordButton.widthAnchor.constraint(equalToConstant: 22),

            deletingTextdButton.trailingAnchor.constraint(equalTo: addressView.trailingAnchor, constant: -15),
            deletingTextdButton.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 15),
            deletingTextdButton.heightAnchor.constraint(equalToConstant: 20),
            deletingTextdButton.widthAnchor.constraint(equalToConstant: 20)

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

    func setButtonImage(_ image: UIImage) {
        hideOpenPasswordButton.setImage(image, for: .normal)
    }

    @objc private func buttonTapped() {
        presenter?.buttonTapped()
    }

    // кнопка где должен быть загружен спинер
    @objc private func clickLoginButton() {}

    @objc private func kbWillShow(_ notification: Notification) {
        print("kbWillShow")
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue
        )?.cgRectValue {
            loginButton.frame.origin.y = view.bounds.height - keyboardSize.height - 60
        }
    }

    @objc private func kbWillHide(_ notification: Notification) {
        print("kbWillHide")
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue
        )?.cgRectValue {
            loginButton.frame.origin.y = view.bounds.maxY - view.safeAreaInsets.bottom - 60
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // валидация
    private let minLenght = 6
    private lazy var regexEmail =
        "^(?=.*[а-я])(?=.*[А-Я])(?=.*\\d)(?=.*[$@$!%*?&#])[А-Яа-я\\d$@$!%*?&#]{\(minLenght),}$"
    private let regexPassword = 123

    private func checkValidation(email: String) {
        guard email.count >= minLenght else {
            warningsEmailLabel.text = ""
            return
        }

        if email.matches(regexEmail) {
            warningsEmailLabel.isHidden = false
        } else {
            warningsEmailLabel.isHidden = true
        }
    }
}

extension AuthView: AuthViewInput {}

extension String {
    func matches(_ regex: String) -> Bool {
        range(of: regex, options: .regularExpression, range: nil, locale: nil) !=
            nil
    }
}

extension AuthView: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let password = passwordTextField.text ?? ""
        let login = emailTextField.text ?? ""

        if password.count > 6, login.count > 6 {
            warningsEmailLabel.isHidden = false
            warningsPasswordLabel.isHidden = false
        }

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("DDD")
    }
}

// comiteints проверка
