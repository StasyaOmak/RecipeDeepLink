// ProfileView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс общения с ProfileView
protocol ProfileViewInput: AnyObject {
    func presentBonucesDetailScreen()
    func presentCurrentlyUnderDevelopmentAlert()
    func presentLogOutAlert()
    func presentNameChangeAlert()
    func reloadFirstRow()
}

/// Вью экрана профиля пользователя
final class ProfileView: UIViewController {
    // MARK: - Types

    /// Секции таблицы экрана профиля
    private enum ProfileSection {
        /// Секция с ячейкой профиля пользователя
        case header
        /// Секция с доступными настройками
        case settings
    }

    // MARK: - Constants

    private enum Constants {
        static let titleText = "Profile".attributed().withColor(.label).withFont(.verdanaBold?.withSize(28))
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

    var presenter: ProfilePresenterInput?

    // MARK: - Private Properties

    private let profileTableSections: [ProfileSection] = [.header, .settings]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        let titleLabel = UILabel()
        titleLabel.attributedText = Constants.titleText
        titleLabel.textAlignment = .left
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        view.addSubview(tableView)
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
}

extension ProfileView: ProfileViewInput {
    func presentBonucesDetailScreen() {}

    func presentCurrentlyUnderDevelopmentAlert() {
        let alert = UIAlertController(title: Constants.underDevelopmentText)
        let okAction = UIAlertAction(title: Constants.okText)
        alert.addAction(okAction)
        alert.preferredAction = okAction
        present(alert, animated: true)
    }

    func presentLogOutAlert() {
        let alert = UIAlertController(title: Constants.logOutAlertTitleText)
        let yesAction = UIAlertAction(title: Constants.yesText, style: .destructive)
        let cancelAction = UIAlertAction(title: Constants.cancelText)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        alert.preferredAction = cancelAction
        present(alert, animated: true)
    }

    func presentNameChangeAlert() {
        let alert = UIAlertController(title: Constants.changeNameText)
        let okAction = UIAlertAction(title: Constants.okText) { [weak alert, presenter] _ in
            guard let newName = alert?.textFields?[0].text else { return }
            presenter?.didSubmitNewName(newName)
        }
        let cancelAction = UIAlertAction(title: Constants.cancelText)
        alert.addTextField { textfield in
            textfield.placeholder = Constants.changeNamePlaceholder
            textfield.font = .verdana?.withSize(16)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.preferredAction = okAction
        present(alert, animated: true)
    }

    func reloadFirstRow() {
        tableView.reloadRows(at: [.init(row: 0, section: 0)], with: .automatic)
    }
}

extension ProfileView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        profileTableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch profileTableSections[section] {
        case .header:
            1
        case .settings:
            presenter?.getAmountOfSettings() ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch profileTableSections[indexPath.section] {
        case .header:
            guard let user = presenter?.getUser(),
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: ProfileCell.description(),
                      for: indexPath
                  ) as? ProfileCell
            else { return UITableViewCell() }

            cell.onEditButtonTapped = { [presenter] in
                presenter?.profileEditButtonTapped()
            }
            cell.configure(with: user)
            return cell
        case .settings:
            guard let setting = presenter?.getSetting(forIndex: indexPath.row),
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
        if case .settings = profileTableSections[indexPath.section] {
            presenter?.selectedSettingCell(atIndex: indexPath.row)
        }
    }
}
