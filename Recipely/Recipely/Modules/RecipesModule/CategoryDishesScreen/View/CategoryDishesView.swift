// CategoryDishesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с CategoryDishesView
protocol CategoryDishesViewProtocol: AnyObject {
    /// Обновляет состояние вью
    func updateState()
}

/// Вью экрана списка блюд категории
class CategoryDishesView: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Constants

    private enum Constants {
        static let caloriesFilterText = "Calories"
        static let timeFilterText = "Time"
        static let placeholderText = "Search recipes"
        static let titleLabelText = "Failed to load data"
        static let reloadText = "Reload"
        static let noDataPlaceholderViewText = "Start typing text"
    }

    // MARK: - Visual Components

    private lazy var refreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlTapped(_:)), for: .valueChanged)
        return control
    }()

    private lazy var searhBar = {
        let searhBar = UISearchBar()
        searhBar.searchTextField.borderStyle = .none
        searhBar.searchBarStyle = .minimal
        searhBar.searchTextField.backgroundColor = UIColor.searhBar
        searhBar.searchTextField.layer.cornerRadius = 12
        searhBar.placeholder = Constants.placeholderText
        searhBar.translatesAutoresizingMaskIntoConstraints = false
        searhBar.delegate = self
        return searhBar
    }()

    private lazy var caloriesSortControl = {
        let view = SortControl(title: Constants.caloriesFilterText, state: .none)
        view.delegate = self
        return view
    }()

    private lazy var timeSortControl = {
        let view = SortControl(title: Constants.timeFilterText, state: .none)
        view.delegate = self
        return view
    }()

    private lazy var tableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.refreshControl = refreshControl
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.rowHeight = UITableView.automaticDimension
        table.register(DishCell.self, forCellReuseIdentifier: DishCell.description())
        table.register(DishShimmerCell.self, forCellReuseIdentifier: DishShimmerCell.description())
        return table
    }()

    private let errorPlaceholderView = {
        let view = CategoryPlaceholderView()
        view.isHiddenNothingFoundLabel = true
        view.isHiddenAnotherRequestLabel = true
        view.reloadText = Constants.reloadText
        view.titleLabelText = Constants.titleLabelText
        view.image = UIImage(named: "mistake")
        view.imageLoading = .reloadIcon
        return view
    }()

    private let noDataPlaceholderView = {
        let view = CategoryPlaceholderView()
        view.isHiddenNothingFoundLabel = true
        view.isHiddenAnotherRequestLabel = true
        view.isHiddenImageButton = true
        view.isHiddenReloadText = true
        view.isHiddenBackgroundView = true
        view.titleLabelText = Constants.noDataPlaceholderViewText
        view.image = UIImage(named: "magnifier")
        return view
    }()

    private let nothingFoundPlaceholderView = {
        let view = CategoryPlaceholderView()
        view.isHiddenNothingFoundLabel = false
        view.isHiddenAnotherRequestLabel = false
        view.isHiddenBackgroundView = true
        view.isHiddenImageButton = true
        view.isHiddenReloadText = true
        view.isHiddenTitleLabel = true
        view.image = UIImage(named: "magnifier")
        return view
    }()

    // MARK: - Public Properties

    var presenter: CategoryDishesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        presenter?.viewLoaded()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deselectSelectedRow()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(
            tableView,
            searhBar,
            caloriesSortControl,
            timeSortControl,
            errorPlaceholderView,
            nothingFoundPlaceholderView,
            noDataPlaceholderView
        )
        configureNavigationItem()
        errorPlaceholderView.isHidden = true
        nothingFoundPlaceholderView.isHidden = true
        noDataPlaceholderView.isHidden = true
    }

    private func configureLayout() {
        UIView.doNotTAMIC(
            for: tableView,
            searhBar,
            caloriesSortControl,
            timeSortControl,
            errorPlaceholderView,
            nothingFoundPlaceholderView,
            noDataPlaceholderView
        )
        configureSearhBarConstraints()
        configureCaloriesViewConstraints()
        configureTimeViewConstraints()
        configureTableViewConstraits()
        configurePlaceholderViewConstraits()
        configurePlaceholderViewConstraits()
        configureNothingFoundPlaceholderViewConstraits()
        configureNoDataPlaceholderViewConstraits()
    }

    private func configureSearhBarConstraints() {
        [
            searhBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searhBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searhBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            searhBar.heightAnchor.constraint(equalToConstant: 36)
        ].activate()
    }

    private func configureCaloriesViewConstraints() {
        [
            caloriesSortControl.topAnchor.constraint(equalTo: searhBar.bottomAnchor, constant: 20),
            caloriesSortControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ].activate()
    }

    private func configureTimeViewConstraints() {
        [
            timeSortControl.topAnchor.constraint(equalTo: searhBar.bottomAnchor, constant: 20),
            timeSortControl.leadingAnchor.constraint(equalTo: caloriesSortControl.trailingAnchor, constant: 11),
        ].activate()
    }

    private func configureTableViewConstraits() {
        [
            tableView.topAnchor.constraint(equalTo: caloriesSortControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

    private func configureNothingFoundPlaceholderViewConstraits() {
        [
            nothingFoundPlaceholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nothingFoundPlaceholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nothingFoundPlaceholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nothingFoundPlaceholderView.heightAnchor.constraint(equalToConstant: 140)
        ].activate()
    }

    private func configureNoDataPlaceholderViewConstraits() {
        [
            noDataPlaceholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noDataPlaceholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noDataPlaceholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            noDataPlaceholderView.heightAnchor.constraint(equalToConstant: 140)
        ].activate()
    }

    private func configureNavigationItem() {
        let backButtonItem = UIBarButtonItem(
            image: .backArrow.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: nil,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        let titleLabel = UILabel()
        let title = presenter?.getTitle() ?? ""
        titleLabel.attributedText = title.attributed()
            .withColor(.label)
            .withFont(.verdanaBold(size: 28))
        titleLabel.textAlignment = .left
        navigationItem.leftBarButtonItems?.append(UIBarButtonItem(customView: titleLabel))
    }

    private func deselectSelectedRow() {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.cellForRow(at: selectedIndex)?.isSelected = false
        }
    }

    @objc private func refreshControlTapped(_ sender: UIRefreshControl) {
        presenter?.viewLoaded()
        updateState()
        sender.endRefreshing()
    }
}

extension CategoryDishesView: CategoryDishesViewProtocol {
    func updateState() {
        switch presenter?.state {
        case .loading, .data:
            tableView.reloadData()
        case .noData:
            print("no data")
        case .error, .none:
            print("error")
        }
    }
}

extension CategoryDishesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter?.state {
        case .loading:
            6
        case let .data(dishes):
            dishes.count
        case .noData, .error, .none:
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
        case let .data(dishes):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DishCell.description(),
                for: indexPath
            ) as? DishCell else { return UITableViewCell() }
            cell.configure(with: dishes[indexPath.row])

            presenter?.getImageForCell(atIndex: indexPath.row) { imageData, index in
                guard let image = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    let currentIndexOfUpdatingCell = tableView.indexPath(for: cell)?.row
                    guard currentIndexOfUpdatingCell == index else { return }
                    cell.setDishImage(image)
                }
            }
            return cell
        case .noData, .error, .none:
            break
        }
        return UITableViewCell()
    }
}

extension CategoryDishesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapCell(atIndex: indexPath.row)

        tableView.cellForRow(at: indexPath)?.isSelected = true
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}

extension CategoryDishesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchBarTextChanged(to: searchText)
    }
}

extension CategoryDishesView: SortControlDelegate {
    func sotingControl(_ control: SortControl, changedStateTo state: SortState) {
        switch control {
        case timeSortControl:
            presenter?.timeSortControlChanged(toState: state)
        case caloriesSortControl:
            presenter?.caloriesSortControlChanged(toState: state)
        default:
            break
        }
    }
}
