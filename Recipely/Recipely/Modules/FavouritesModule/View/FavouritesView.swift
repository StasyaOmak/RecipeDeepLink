// FavouritesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с FavouritesView
protocol FavouritesViewProtocol: AnyObject {}

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
        table.delegate = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.reloadData()
        table.rowHeight = UITableView.automaticDimension
        table.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.description())
        return table
    }()

    private let messageEmptyFavoriteView = CustomView()

    // MARK: - Private Properties

    private let content: [CellTypes] = [.favorites]

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

extension FavouritesView: FavouritesViewProtocol {}

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
                      withIdentifier: RecipeCell.description(),
                      for: indexPath
                  ) as? RecipeCell else { return UITableViewCell() }
            cell.configureCell(category: recipes)

//            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
//            swipeGesture.direction = .left
//            cell.addGestureRecognizer(swipeGesture)
            return cell
        }
    }

//    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
    ////        if let indexPath = tableView.indexPathForItem(at: gesture.location(in: collectionView)) {
    ////            if gesture.state == .ended {
    ////                episodeCharacter.remove(at: indexPath.item)
    ////                collectionView.deleteItems(at: [indexPath])
    ////            }
    ////        }
//    }
}

extension FavouritesView: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        if let recipes = presenter?.getSections(forIndex: <#Int#>) {
            let deleteButton = UIContextualAction(style: .destructive, title: "Delete") { _, _, complitionHand in
                        recipes.remove(at: indexPath.row)
        ////                tableView.delete(at: [indexPath], with: .fade)
//            }

//            deleteButton.backgroundColor = .red

        UISwipeActionsConfiguration()
        }
//        return nil
    }
}
