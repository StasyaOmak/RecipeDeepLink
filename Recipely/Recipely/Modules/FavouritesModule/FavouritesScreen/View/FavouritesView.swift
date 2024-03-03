// FavouritesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с FavouritesView
protocol FavouritesViewProtocol: AnyObject {
    /// проверяет массив на пустоту
    func checkEmptiness(state: Bool)
}

/// Вью экрана сохранненных рецептов
final class FavouritesView: UIViewController {
    // MARK: - Types

    private enum CellTypes {
        /// Тип ячейки рецепта
        case favorites
    }

    // MARK: - Constants

    private enum Constants {
        static let titleText = "Favorites"
    }

    // MARK: - Visual Components

    private lazy var tableView = {
        let table = UITableView()
        table.dataSource = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.rowHeight = UITableView.automaticDimension
        table.register(FavouritesCell.self, forCellReuseIdentifier: FavouritesCell.description())
        return table
    }()

    // MARK: - Private Properties

    private let content: [CellTypes] = [.favorites]
    private let messageEmptyFavoriteView = EmptyFavoritesView()

    // MARK: - Public Properties

    var presenter: FavouritesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(tableView, messageEmptyFavoriteView)
        configureTitleLabel()
    }

    private func configureTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.attributedText = Constants.titleText.attributed().withColor(.label)
            .withFont(.verdanaBold?.withSize(28))
        titleLabel.textAlignment = .left
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: tableView, messageEmptyFavoriteView)
        configureTableViewLayout()
        configureMessageEmptyFavoriteViewLayout()
        messageEmptyFavoriteView.isHidden = true
    }

    private func configureTableViewLayout() {
        [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].activate()
    }

    private func configureMessageEmptyFavoriteViewLayout() {
        [
            messageEmptyFavoriteView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageEmptyFavoriteView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageEmptyFavoriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            messageEmptyFavoriteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageEmptyFavoriteView.heightAnchor.constraint(equalToConstant: 132)
        ].activate()
    }
}

extension FavouritesView: FavouritesViewProtocol {
    func checkEmptiness(state: Bool) {
        switch state {
        case true:
            messageEmptyFavoriteView.isHidden = false
        case false:
            messageEmptyFavoriteView.isHidden = true
        }
    }
}

extension FavouritesView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        content.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getAmountOfSubSections() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = content[indexPath.section]
        switch items {
        case .favorites:
            guard let recipes = presenter?.getSections(forIndex: indexPath.row),
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: FavouritesCell.description(),
                      for: indexPath
                  ) as? FavouritesCell else { return UITableViewCell() }
            cell.configureCell(category: recipes)
            return cell
        }
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        presenter?.removeItem(forIndex: indexPath.section)
        tableView.deleteRows(at: [indexPath], with: .fade)
        presenter?.checkEmptiness()
    }
}
