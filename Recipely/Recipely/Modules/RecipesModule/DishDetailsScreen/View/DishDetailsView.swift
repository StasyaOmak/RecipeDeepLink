// DishDetailsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с DishDetailsView
protocol DishDetailsViewProtocol: AnyObject {
    /// Обновляет состояние вью
    func updateState()
    /// Обновляет состояние кнопки добавления блюда в избранное
    func updateFavouritesButtonState(to isHighlited: Bool)
}

/// Экран детальной информации о блюде
final class DishDetailsView: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Types

    /// Тип ячейки описания блюда
    enum DishCellType {
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
        static let titleLabelText = "Failed to load data"
        static let reloadText = "Reload"
    }

    // MARK: - Visual Components

    private lazy var shareButton = {
        let button = UIButton()
        button.setImage(.shareIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var refreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(reloadActionCommited(_:)), for: .valueChanged)
        return control
    }()

    private lazy var addToFavouritesButton = {
        let button = UIButton()
        button.setImage(.bookmarkIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addToFavouritesButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var dishInfoTableView = {
        let table = UITableView()
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.refreshControl = refreshControl
        table.showsVerticalScrollIndicator = false
        table.register(DishInfoCell.self, forCellReuseIdentifier: DishInfoCell.description())
        table.register(DishKBZHUCell.self, forCellReuseIdentifier: DishKBZHUCell.description())
        table.register(DishRecipeCell.self, forCellReuseIdentifier: DishRecipeCell.description())
        table.register(RecipeShimmerCell.self, forCellReuseIdentifier: RecipeShimmerCell.description())
        return table
    }()

    private lazy var placeholerView = {
        let view = CategoryDishesPlaceholderView()
        view.addTarget(self, action: #selector(reloadActionCommited))
        return view
    }()

    // MARK: - Public Properties

    var presenter: DishDetailsPresenterProtocol?

    // MARK: - Private Properties

    private var dishInfoTableViewCells: [DishCellType] = [.dish, .KBZHU, .recipe]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        presenter?.requestDishUpdate()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(dishInfoTableView, placeholerView)
        configureNavigationBarItems()
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: dishInfoTableView, placeholerView)
        dishInfoTableViewConfigureLayout()
        placeholderViewConfigureLayout()
    }

    private func dishInfoTableViewConfigureLayout() {
        [
            dishInfoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dishInfoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dishInfoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dishInfoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }

    private func placeholderViewConfigureLayout() {
        [
            placeholerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            placeholerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
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

        let shareButtonItem = UIBarButtonItem(customView: shareButton)
        let addToFavouritesButtonItem = UIBarButtonItem(customView: addToFavouritesButton)
        navigationItem.rightBarButtonItems = [addToFavouritesButtonItem, shareButtonItem]
    }

    @objc private func addToFavouritesButtonTapped() {
        presenter?.addToFavouritesButtonTapped()
    }

    @objc private func shareButtonTapped() {
        presenter?.shareButtonTapped()
    }

    @objc private func reloadActionCommited(_ sender: UIView) {
        if sender == refreshControl {
            refreshControl.endRefreshing()
        }
        presenter?.requestDishUpdate()
    }
}

extension DishDetailsView: DishDetailsViewProtocol {
    func updateState() {
        switch presenter?.state {
        case .loading:
            placeholerView.switchToState(.hidden)
            dishInfoTableView.isHidden = false
            dishInfoTableView.isScrollEnabled = false
        case let .data(dish):
            placeholerView.switchToState(.hidden)
            dishInfoTableView.isHidden = false
            dishInfoTableView.isScrollEnabled = true
            updateFavouritesButtonState(to: dish.isFavourite)
        case .noData:
            dishInfoTableView.isHidden = true
        case .error, .none:
            dishInfoTableView.isHidden = true
            placeholerView.switchToState(.error)
        }
        dishInfoTableView.reloadData()
    }

    func updateFavouritesButtonState(to isFavourite: Bool) {
        let image: UIImage = isFavourite ? .bookmarkSelectedIcon : .bookmarkIcon
        addToFavouritesButton.setImage(image, for: .normal)
    }
}

extension DishDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter?.state {
        case .data:
            dishInfoTableViewCells.count
        case .loading:
            1
        case .noData, .error, .none:
            0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter else { return UITableViewCell() }
        switch presenter.state {
        case .loading:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeShimmerCell.description(),
                for: indexPath
            ) as? RecipeShimmerCell else { return UITableViewCell() }
            return cell
        case let .data(dish):
            switch dishInfoTableViewCells[indexPath.row] {
            case .dish:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: DishInfoCell.description(),
                    for: indexPath
                ) as? DishInfoCell
                else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(with: dish)

                presenter.getDishImage { imageData in
                    guard let image = UIImage(data: imageData) else { return }
                    DispatchQueue.main.async {
                        cell.setDishImage(image)
                    }
                }
                return cell

            case .KBZHU:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: DishKBZHUCell.description(),
                    for: indexPath
                ) as? DishKBZHUCell
                else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(with: dish)
                return cell
            case .recipe:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: DishRecipeCell.description(),
                    for: indexPath
                ) as? DishRecipeCell
                else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(with: dish)
                return cell
            }
        case .noData, .error:
            break
        }
        return UITableViewCell()
    }
}
