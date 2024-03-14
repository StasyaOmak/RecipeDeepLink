// DishDetailsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с DishDetailsView
protocol DishDetailsViewProtocol: AnyObject {
    /// Конфигурирует экран используя информацию о переданном блюде
    func configure(with dish: Dish?)
    /// Покрасить значок избранное
    func updateFavouritesButtonState(to isHighlited: Bool)
    /// Обновляет состояние вью
    func updateState()
}

/// Экран детальной информации о блюде
final class DishDetailsView: UIViewController, UIGestureRecognizerDelegate {
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

    private lazy var shareButton = {
        let button = UIButton()
        button.setImage(.shareIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
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
        table.register(DishInfoCell.self, forCellReuseIdentifier: DishInfoCell.description())
        table.register(DishKBZHUCell.self, forCellReuseIdentifier: DishKBZHUCell.description())
        table.register(DishRecipeCell.self, forCellReuseIdentifier: DishRecipeCell.description())
        return table
    }()

    // MARK: - Public Properties

    var presenter: DishDetailsPresenterProtocol?

    // MARK: - Private Properties

    private var dish: Dish?
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
        view.addSubview(dishInfoTableView)
        configureNavigationBarItems()
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: dishInfoTableView)
        [
            dishInfoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dishInfoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dishInfoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dishInfoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
}

extension DishDetailsView: DishDetailsViewProtocol {
    func updateState() {
        switch presenter?.state {
        case .loading, .data:
            dishInfoTableView.reloadData()
        case .noData:
            print("noData")
        case .error, .none:
            print("error")
        }
    }

    func updateFavouritesButtonState(to isHighlited: Bool) {
        let image: UIImage = isHighlited ? .bookmarkSelectedIcon : .bookmarkIcon
        addToFavouritesButton.setImage(image, for: .normal)
    }

    func configure(with dish: Dish?) {
        self.dish = dish
    }
}

extension DishDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter?.state {
        case .data:
            dishInfoTableViewCells.count
        case .noData, .error, .loading, .none:
            0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter?.state {
        case .loading:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DishShimmerCell.description(),
                for: indexPath
            ) as? DishShimmerCell else { return UITableViewCell() }
            return cell
        case let .data(recipe):
            switch dishInfoTableViewCells[indexPath.row] {
            case .dish:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: DishInfoCell.description(),
                    for: indexPath
                ) as? DishInfoCell
                else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(with: recipe)
                return cell
            case .KBZHU:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: DishKBZHUCell.description(),
                    for: indexPath
                ) as? DishKBZHUCell
                else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(with: recipe)
                return cell
            case .recipe:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: DishRecipeCell.description(),
                    for: indexPath
                ) as? DishRecipeCell
                else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(with: recipe)
                return cell
            }
        case .noData, .error, .none:
            break
        }
        return UITableViewCell()
    }
}
