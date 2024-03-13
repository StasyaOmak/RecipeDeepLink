// FavouritesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с FavouritesView
protocol FavouritesViewProtocol: AnyObject {
    /// Показывает/скрывает плесхолдер под таблицей
    func setPlaceholderViewIsHidden(to isHidden: Bool)
    /// Просит перезгрузить таблицу
    func reloadTable()
    /// Проси добавить ряд в таблицу
    func tableViewAppendRow()
    /// Просит таблицу удалить ряд по индексу
    func tableViewDeleteRow(atIndex index: Int)
}

/// Вью экрана сохранненных блюд
final class FavouritesView: UIViewController {
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

    // MARK: - Public Properties

    var presenter: FavouritesPresenterProtocol?

    // MARK: - Private Properties

    private let placeholderView = FavoritesPlaceholderView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(tableView, placeholderView)
        placeholderView.isHidden = true
        configureTitleLabel()
    }

    private func configureTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.attributedText = Constants.titleText.attributed()
            .withColor(.label)
            .withFont(.verdanaBold(size: 28))
        titleLabel.textAlignment = .left
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: tableView, placeholderView)
        configureTableViewLayout()
        configurePlaceholderViewLayout()
    }

    private func configureTableViewLayout() {
        [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].activate()
    }

    private func configurePlaceholderViewLayout() {
        [
            placeholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            placeholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            placeholderView.heightAnchor.constraint(equalToConstant: 132)
        ].activate()
    }
}

extension FavouritesView: FavouritesViewProtocol {
    func setPlaceholderViewIsHidden(to isHidden: Bool) {
        placeholderView.isHidden = isHidden
    }

    func reloadTable() {
        tableView.reloadData()
    }

    func tableViewAppendRow() {
        guard let numberOfRows = presenter?.getNumberOfDishes() else { return }
        let insertionIndexPath = IndexPath(row: numberOfRows - 1, section: 0)
        tableView.insertRows(at: [insertionIndexPath], with: .none)
    }

    func tableViewDeleteRow(atIndex index: Int) {
        let deletionIndexPath = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [deletionIndexPath], with: .none)
    }
}

extension FavouritesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getNumberOfDishes() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dish = presenter?.getDish(forIndex: indexPath.row),
              let cell = tableView.dequeueReusableCell(
                  withIdentifier: FavouritesCell.description(),
                  for: indexPath
              ) as? FavouritesCell else { return UITableViewCell() }
        cell.configure(with: dish)
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        presenter?.removeItem(atIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
