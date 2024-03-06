// CategoryDishesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с CategoryDishesView
protocol CategoryDishesViewProtocol: AnyObject {
    /// Функция для изменения состояния контрола сортировки калорий
    func changesCaloriesSortingStatus(condition: Condition)
    /// Функция для изменения состояния контрола сортировки по времени
    func changesTimeSortingStatus(condition: Condition)
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

    private lazy var caloriesView = {
        let view = SortingControlView()
        view.tag = 0
        view.changeParameters(title: Constants.caloriesText, image: .stackIcon)
        let tapGestureCalories = UITapGestureRecognizer(target: self, action: #selector(sortControllTapped(_:)))
        view.addGestureRecognizer(tapGestureCalories)
        return view
    }()

    private lazy var timeView = {
        let view = SortingControlView()
        view.tag = 1
        view.changeParameters(title: Constants.timeText, image: .stackIcon)
        let tapGestureCalories = UITapGestureRecognizer(target: self, action: #selector(sortControllTapped(_:)))
        view.addGestureRecognizer(tapGestureCalories)
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
        view.addSubviews(tableView, searhBar, caloriesView, timeView)
        configureNavigationItem()
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: tableView, searhBar, caloriesView, timeView)
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
            caloriesView.topAnchor.constraint(equalTo: searhBar.bottomAnchor, constant: 20),
            caloriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ].activate()
    }

    private func configureTimeViewConstraints() {
        [
            timeView.topAnchor.constraint(equalTo: searhBar.bottomAnchor, constant: 20),
            timeView.leadingAnchor.constraint(equalTo: caloriesView.trailingAnchor, constant: 11),
        ].activate()
    }

    private func configureTableViewConstraits() {
        [
            tableView.topAnchor.constraint(equalTo: caloriesView.bottomAnchor, constant: 10),
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

    @objc private func sortControllTapped(_ sender: UITapGestureRecognizer) {
        switch sender.view?.tag {
        case 0:
            presenter?.changesCaloriesSortingStatus()
        case 1:
            presenter?.changesTimeSortingStatus()
        default:
            break
        }
    }
}

extension CategoryDishesView: CategoryDishesViewProtocol {
    func reloadDishes() {
        tableView.reloadData()
    }

    func changesTimeSortingStatus(condition: Condition) {
        switch condition {
        case .notPressed:
            timeView.backgroundColor = .recipeView
            timeView.changeParameters(title: Constants.timeText, image: .stackIcon)
        case .sortingMore:
            timeView.backgroundColor = .accent
            timeView.changeParameters(title: Constants.timeText, image: .stackIcon.withTintColor(.white))
        case .sortingSmaller:
            guard let image = UIImage.stackIcon.cgImage else { return }
            let newImage = UIImage(cgImage: image, scale: 1, orientation: .downMirrored).withTintColor(.white)
            timeView.backgroundColor = .accent
            timeView.changeParameters(title: Constants.timeText, image: newImage)
        }
    }

    func changesCaloriesSortingStatus(condition: Condition) {
        switch condition {
        case .notPressed:
            caloriesView.backgroundColor = .recipeView
            caloriesView.changeParameters(title: Constants.caloriesText, image: .stackIcon)
        case .sortingMore:
            caloriesView.backgroundColor = .accent
            caloriesView.changeParameters(title: Constants.caloriesText, image: .stackIcon.withTintColor(.white))
        case .sortingSmaller:
            guard let image = UIImage.stackIcon.cgImage else { return }
            let newImage = UIImage(cgImage: image, scale: 1, orientation: .downMirrored).withTintColor(.white)
            caloriesView.backgroundColor = .accent
            caloriesView.changeParameters(title: Constants.caloriesText, image: newImage)
        }
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
        case .noData:
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
