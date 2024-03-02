// RecipeDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с RecipeDetailView
protocol RecipeDetailViewProtocol: AnyObject {
    /// Конфигурирует экран используя информацию о переданном блюде
    func configure(with dish: Dish)
}

/// Экран делальной информации о блюде
final class RecipeDetailView: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Types

    /// Тип ячейки описания блюда
    enum DichCellType {
        /// Ячейка с сновной ииформацией
        case dish
        /// Ячейка с информацией о КБЖУ
        case KBZHU
        /// Ячейка с рецептом
        case recipe
    }

    // MARK: - Constants

    private enum Constants {
        static let inDevelopmentText = "Функционал в разработке"
        static let okText = "Ok"
    }

    // MARK: - Visual Components

    private lazy var dichInfoTableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.register(DishInfoCell.self, forCellReuseIdentifier: DishInfoCell.description())
        table.register(KBZHUCell.self, forCellReuseIdentifier: KBZHUCell.description())
        table.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.description())
        return table
    }()

    // MARK: - Public Properties

    var presenter: RecipeDetailPresenterProtocol?

    // MARK: - Private Properties

    private var dish: Dish!
    private var dishInfoTableViewCells: [DichCellType] = [.dish, .KBZHU, .recipe]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        presenter?.viewBeganLoading()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(dichInfoTableView)
        configureNavigationBarItems()
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: dichInfoTableView)
        [
            dichInfoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dichInfoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dichInfoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dichInfoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }

    private func configureNavigationBarItems() {
        let backButtonItem = UIBarButtonItem(
            image: .backArrow.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: nil,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        let shareButton = UIButton()
        shareButton.setImage(.shareIcon.withRenderingMode(.alwaysOriginal), for: .normal)

        let addToFavouritesButton = UIButton()
        addToFavouritesButton.setImage(.bookmarkIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        addToFavouritesButton.addTarget(self, action: #selector(addToFavouritesButtonTapped), for: .touchUpInside)

        let shareButtonItem = UIBarButtonItem(customView: shareButton)
        let addToFavouritesButtonItem = UIBarButtonItem(customView: addToFavouritesButton)
        navigationItem.rightBarButtonItems = [addToFavouritesButtonItem, shareButtonItem]
    }

    private func showInDevelopmentAlert() {
        let alert = UIAlertController(message: Constants.inDevelopmentText)
        let okAction = UIAlertAction(title: Constants.okText)
        alert.addAction(okAction)
        alert.preferredAction = okAction
        present(alert, animated: true)
    }

    @objc private func addToFavouritesButtonTapped() {
        showInDevelopmentAlert()
    }
}

extension RecipeDetailView: RecipeDetailViewProtocol {}

extension RecipeDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishInfoTableViewCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dishInfoTableViewCells[indexPath.row] {
        case .dish:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DishInfoCell.description(),
                for: indexPath
            ) as? DishInfoCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.configure(with: dish)
            return cell
        case .KBZHU:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: KBZHUCell.description(),
                for: indexPath
            ) as? KBZHUCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.configure(with: dish)
            return cell
        case .recipe:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeCell.description(),
                for: indexPath
            ) as? RecipeCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.configure(with: dish)
            return cell
        }
    }
}

extension RecipeDetailView: UITableViewDelegate {
    func configure(with dish: Dish) {
        self.dish = dish
    }
}
