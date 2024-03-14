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

    func errorView(state: ViewState<Any>)
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
        static let titleLabelText = "Failed to load data"
        static let reloadText = "Reload"
    }

    // MARK: - Visual Components

    private var errorPlaceholderView = {
        let view = CategoryPlaceholderView()
        view.isHiddenNothingFoundLabel = true
        view.isHiddenAnotherRequestLabel = true
        view.reloadText = Constants.reloadText
        view.titleLabelText = Constants.titleLabelText
        view.image = UIImage(named: "mistake")
        view.imageLoading = .reloadIcon
        view.isHidden = true
        return view
    }()

    private lazy var shareButton = {
        let button = UIButton()
        button.setImage(.shareIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var refreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlTapped(_:)), for: .valueChanged)
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
        table.register(DishInfoCell.self, forCellReuseIdentifier: DishInfoCell.description())
        table.register(DishKBZHUCell.self, forCellReuseIdentifier: DishKBZHUCell.description())
        table.register(DishRecipeCell.self, forCellReuseIdentifier: DishRecipeCell.description())
        table.register(RecipeShimmerCell.self, forCellReuseIdentifier: RecipeShimmerCell.description())
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
        presenter?.viewLoaded()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(dishInfoTableView, errorPlaceholderView)
        configureNavigationBarItems()
        configurePlaceholderViewConstraits()
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: dishInfoTableView, errorPlaceholderView)
        [
            dishInfoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dishInfoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dishInfoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dishInfoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }

    private func configurePlaceholderViewConstraits() {
        [
            errorPlaceholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorPlaceholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorPlaceholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorPlaceholderView.heightAnchor.constraint(equalToConstant: 140)
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

    @objc private func refreshControlTapped(_ sender: UIRefreshControl) {
        presenter?.viewLoaded()
        updateState()
        sender.endRefreshing()
    }
}

extension DishDetailsView: DishDetailsViewProtocol {
    func errorView(state: ViewState<Any>) {
        switch state {
        case .error:
            errorPlaceholderView.isHidden = false
        case .data:
            errorPlaceholderView.isHidden = true
        case .loading, .noData:
            break
        }
    }

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
        case .loading:
            1
        case .noData, .error, .none:
            0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter?.state {
        case .loading:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeShimmerCell.description(),
                for: indexPath
            ) as? RecipeShimmerCell else { return UITableViewCell() }
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

                presenter?.getImageForCell(atIndex: indexPath.row) { imageData, index in
                    guard let image = UIImage(data: imageData) else { return }
                    DispatchQueue.main.async {
                        let currentIndexOfUpdatingCell = tableView.indexPath(for: cell)?.row
                        guard currentIndexOfUpdatingCell == index else { return }
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
//        case .noData:
//            break
//        case .error:
//            errorPlaceholderView.isHidden = true
//        case .none:
//            break
        }
        return UITableViewCell()
    }
}
