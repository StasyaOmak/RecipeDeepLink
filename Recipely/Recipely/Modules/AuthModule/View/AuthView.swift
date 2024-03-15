// AuthView.swift
// Copyright © RoadMap. All rights reserved.

// import Photos
import UIKit

/// Интерфейс взаимодействия с AuthView
protocol AuthViewProtocol: AnyObject {
    /// функция для проверки на валидность email
    func setEmailFieldStateTo(_ state: AuthFieldView.AuthTextFieldState)
    /// функция для проверки на валидность password
    func setPasswordFieldStateTo(_ state: AuthFieldView.AuthTextFieldState)
    /// функция для проверки запуска активити индикатора
    func startIndicator()
    /// функция для проверки остановки активити индикатора
    func stopIndicator()
    /// функция для отображения предупреждений об ошибке при авторизации
    func showWarning()
    /// Функция для отображения  кнопки удаления текста
    func displayDeleteTextButton(isHidden: Bool)
}

/// Вью экрана аутентификаци
final class AuthView: UIViewController {
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

    private let passwordTextFieldView = {
        let view = AuthFieldView(selectorMethod: nil, view: nil)
        view.placeholderText = Constants.enterPassword
        view.titleLabelText = Constants.passwordText
        view.warningText = Constants.passwordWarningText
        view.leftAccessoryImage = .lockIcon
        view.rightAccessoryButtonImage = .crossedEyeIcon
        view.isRightButtonHidden = false
        return view
    }()

    private let loginLabel = {
        let label = UILabel()
        label.text = Constants.loginText
        label.font = .verdanaBold(size: 28)
        label.textColor = .textAccent
        return label
    }()

    private let loginView: UIView = {
        let view = UIView()
        view.backgroundColor = .warnings
        view.layer.cornerRadius = 12
        view.alpha = 0
        return view
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
    private var loginButtonBottomAnchor: NSLayoutConstraint?

    private lazy var emailTextFieldView = {
        let view = AuthFieldView(selectorMethod: #selector(self.emailChanged(_:)), view: self)
        view.placeholderText = Constants.emailPlaceholder
        view.titleLabelText = Constants.emailAddressText
        view.warningText = Constants.emailWarningText
        view.leftAccessoryImage = .envelopeIcon
        view.rightAccessoryButtonImage = .crossInCircleIcon
        view.isRightButtonHidden = true
        return view
    }()

    private lazy var loginButton = {
        let button = ActivityButton()
        button.setTitle(Constants.loginText, for: .normal)
        button.addTarget(self, action: #selector(
            loginButtonTapped
        ), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var presenter: AuthPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubview()
        configureLayout()
    }

    deinit {
        print("deinit ", String(describing: self))
    }

    // MARK: - Private Methods

    private func addSubview() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )

        let subviews = [
            loginButton,
            loginLabel,
            loginView,
            warningsAccuracyLabel,
            passwordTextFieldView,
            emailTextFieldView
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

    private func configureLayout() {
        configureLoginButtonLayout()
        configureLoginLabelLayout()
        configureWarningsAccuracyLabelLayout()
        configureLoginViewLayout()
        configureEmailTextFieldViewLayout()
        configurePasswordTextFieldViewLayout()
    }

    private func configureLoginLabelLayout() {
        [
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 82),
            loginLabel.heightAnchor.constraint(equalToConstant: 32),
            loginLabel.widthAnchor.constraint(equalToConstant: 350)
        ].activate()
    }

    private func configureLoginButtonLayout() {
        loginButtonBottomAnchor = loginButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -37
        )
        loginButtonBottomAnchor?.activate()

        [
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ].activate()
    }

    private func configureWarningsAccuracyLabelLayout() {
        [
            warningsAccuracyLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 15),
            warningsAccuracyLabel.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 16),
            warningsAccuracyLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -34),
            warningsAccuracyLabel.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -17)
        ].activate()
    }

    private func configureLoginViewLayout() {
        [
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: -10),
            loginView.heightAnchor.constraint(equalToConstant: 87)
        ].activate()
    }

    private func configureEmailTextFieldViewLayout() {
        [
            emailTextFieldView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 23),
            emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 107)
        ].activate()
    }

    private func configurePasswordTextFieldViewLayout() {
        [
            passwordTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 4),
            passwordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 107)
        ].activate()
    }

    @objc private func loginButtonTapped() {
        presenter?.loginButtonTapped(withPassword: passwordTextFieldView.text, withEmail: emailTextFieldView.text)
    }

    @objc private func kbWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue
        else { return }
        UIView.animate(withDuration: 0.5) {
            self.loginButtonBottomAnchor?.constant = -(keyboardSize.height)
            self.view.layoutIfNeeded()
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
    func displayDeleteTextButton(isHidden: Bool) {
        emailTextFieldView.isRightButtonHidden = isHidden
    }

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
    }

    func startIndicator() {
        loginButton.startIndicator()
    }

    func setEmailFieldStateTo(_ state: AuthFieldView.AuthTextFieldState) {
        emailTextFieldView.setTextFieldStateTo(state)
    }

    func setPasswordFieldStateTo(_ state: AuthFieldView.AuthTextFieldState) {
        passwordTextFieldView.setTextFieldStateTo(state)
    }
}
