// CategoryDishesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с CategoryDishesView
protocol CategoryDishesViewProtocol: AnyObject {
    /// Функция для обновления данных в таблице
    func reloadDishes()
}

/// Вью экрана списка блюд категории
class CategoryDishesView: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Constants

    private enum Constants {
        static let caloriesText = "Calories"
        static let timeText = "Time"
        static let fishText = "Fish"
        static let placeholderText = "Search recipes"
    }

    // MARK: - Visual Components

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
        let view = SortControl(title: Constants.caloriesText, state: .none)
        view.delegate = self
        return view
    }()

    private lazy var timeSortControl = {
        let view = SortControl(title: Constants.timeText, state: .none)
        view.delegate = self
        return view
    }()

    private lazy var tableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.rowHeight = UITableView.automaticDimension
        table.register(DishCell.self, forCellReuseIdentifier: DishCell.description())
        table.register(DishShimmerCell.self, forCellReuseIdentifier: DishShimmerCell.description())
        return table
    }()

    // MARK: - Public Properties

    var presenter: CategoryDishesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    deinit {
        print("deinit ", String(describing: self))
    }

    override func viewDidAppear(_ animated: Bool) {
        presenter?.viewDidAppear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deselectSelectedRow()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(tableView, searhBar, caloriesSortControl, timeSortControl)
        configureNavigationItem()
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: tableView, searhBar, caloriesSortControl, timeSortControl)
        configureSearhBarConstraints()
        configureCaloriesViewConstraints()
        configureTimeViewConstraints()
        configureTableViewConstraits()
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
}

extension CategoryDishesView: CategoryDishesViewProtocol {
    func reloadDishes() {
        tableView.reloadData()
    }
}

extension CategoryDishesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getNumberDishes() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dish = presenter?.getDish(forIndex: indexPath.row) else { return UITableViewCell() }
        switch dish {
        case let .data(dish):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DishCell.description(),
                for: indexPath
            ) as? DishCell else { return UITableViewCell() }
            cell.configure(with: dish)
            return cell
        case .loading:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DishShimmerCell.description(),
                for: indexPath
            ) as? DishShimmerCell else { return UITableViewCell() }
            return cell
        }
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
