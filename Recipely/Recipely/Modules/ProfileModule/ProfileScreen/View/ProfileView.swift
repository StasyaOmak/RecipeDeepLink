// ProfileView.swift
// Copyright © RoadMap. All rights reserved.

import PhotosUI
import UIKit

/// Интерфейс взаимодействия с ProfileView
protocol ProfileViewProtocol: AnyObject {
    /// Показывает алерт, запрашивающий подтверждение пользователя перед выходом из аккаунта.
    func showLogOutMessage()
    /// Отображает форму для обновления имени пользователя.
    func showUpdateNameForm()
    func showPhotoPicker()

    /// Обновляет отображаемое имя пользователя в соответствующем элементе пользовательского интерфейса.
    func updateUserName(with name: String?)

    func updateProfileImage(with imageData: Data?)
}

/// Вью экрана профиля пользователя
final class ProfileView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Profile"
        static let logOutAlertTitleText = "Are you sure you want to log out?"
        static let underDevelopmentText = "Функционал в разработке"
        static let changeNameText = "Change your name and surname"
        static let changeNamePlaceholder = "Name Surname"
        static let yesText = "Yes"
        static let okText = "Ok"
        static let cancelText = "Cancel"
    }

    // MARK: - Visual Components

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.estimatedRowHeight = UITableView.automaticDimension
        table.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.description())
        table.register(SettingsFieldCell.self, forCellReuseIdentifier: SettingsFieldCell.description())
        return table
    }()

    // MARK: - Public Properties

    var presenter: ProfilePresenterProtocol?

    // MARK: - Private Properties

    private var profileTableSections: [ProfileSection] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        configureTitleLabel()
        profileTableSections = presenter?.getSections() ?? []
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: tableView)
        [
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }

    private func configureTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.attributedText = Constants.titleText.attributed().withColor(.label)
            .withFont(.verdanaBold(size: 28))
        titleLabel.textAlignment = .left
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
}

extension ProfileView: ProfileViewProtocol {
    func showLogOutMessage() {
        let alert = createLogOutMessageAlert()
        present(alert, animated: true)
    }

    func showUpdateNameForm() {
        let alert = createUpdateNameAlert()
        present(alert, animated: true)
    }

    func showPhotoPicker() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    func updateUserName(with name: String?) {
        guard let cell = tableView.cellForRow(at: .init(row: 0, section: 0)) as? ProfileCell else { return }
        cell.updateNameLabel(with: name)
    }

    func updateProfileImage(with imageData: Data?) {
        guard let cell = tableView.cellForRow(at: .init(row: 0, section: 0)) as? ProfileCell else { return }
        cell.updateUserImage(with: imageData)
    }
}

extension ProfileView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        profileTableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch profileTableSections[section] {
        case .userInfo:
            1
        case .subSection:
            presenter?.getAmountOfSubSections() ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch profileTableSections[indexPath.section] {
        case .userInfo:
            guard let user = presenter?.getUser(),
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: ProfileCell.description(),
                      for: indexPath
                  ) as? ProfileCell
            else { return UITableViewCell() }

            cell.onEditButtonTapped = { [presenter] in
                presenter?.profileEditButtonTapped()
            }
            cell.onProfileImageTapped = { [weak self] in
                self?.showPhotoPicker()
            }

            cell.configure(with: user)
            return cell
        case .subSection:
            guard let setting = presenter?.getSubSection(forIndex: indexPath.row),
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: SettingsFieldCell.description(),
                      for: indexPath
                  ) as? SettingsFieldCell
            else { return UITableViewCell() }

            cell.configure(with: setting)
            return cell
        }
    }
}

extension ProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case .subSection = profileTableSections[indexPath.section] {
            presenter?.selectedSubSection(atIndex: indexPath.row)
        }
    }
}

extension ProfileView: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        results.first?.itemProvider.loadObject(ofClass: UIImage.self) { object, _ in
            guard let image = object as? UIImage,
                  let imageData = image.pngData() else { return }
            DispatchQueue.main.async {
                self.presenter?.didSubmitNewProfileImage(imageData)
            }
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - AlertControllers extension

extension ProfileView {
    private func createLogOutMessageAlert() -> UIAlertController {
        let alert = UIAlertController(title: Constants.logOutAlertTitleText)
        let yesAction = UIAlertAction(title: Constants.yesText, style: .destructive) { [weak self] _ in
            self?.presenter?.logOutActionTapped()
        }
        let cancelAction = UIAlertAction(title: Constants.cancelText)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        alert.preferredAction = cancelAction
        return alert
    }

    private func createUpdateNameAlert() -> UIAlertController {
        let alert = UIAlertController(title: Constants.changeNameText)
        let okAction = UIAlertAction(title: Constants.okText) { [weak alert, presenter] _ in
            guard let newName = alert?.textFields?[0].text else { return }
            presenter?.didSubmitNewName(newName)
        }
        let cancelAction = UIAlertAction(title: Constants.cancelText)
        alert.addTextField { textfield in
            textfield.placeholder = Constants.changeNamePlaceholder
            textfield.font = .verdana(size: 16)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.preferredAction = okAction
        return alert
    }
}
