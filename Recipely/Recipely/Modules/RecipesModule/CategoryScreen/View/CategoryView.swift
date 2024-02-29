// CategoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с CategoryView
protocol CategoryViewProtocol: AnyObject {
    // функция для изменения состояния контрола сортировки калорий
    func changesCaloriesSortingStatus(condition: Condition)
    // функция для изменения состояния контрола сортировки по времени
    func changesTimeSortingStatus(condition: Condition)
}

/// Вью экрана категория рецептов
class CategoryView: UIViewController {
    // MARK: - Types

    private enum CellTypes {
        /// Тип ячейки рецепта
        case recipes
    }

    // MARK: - Constants

    private enum Constants {
        static let calories = "Calories"
        static let time = "Time"
        static let fish = "Fish"
    }

    // MARK: - Visual Components

    private let searhBar = {
        let searhBar = UISearchBar()
        searhBar.searchTextField.borderStyle = .none
        searhBar.searchBarStyle = .minimal
        searhBar.searchTextField.backgroundColor = UIColor.searhBar
        searhBar.searchTextField.layer.cornerRadius = 12
        searhBar.placeholder = "Search recipes"
        searhBar.translatesAutoresizingMaskIntoConstraints = false
        return searhBar
    }()

    private let tableView = UITableView()
    private let tapGestureCalories = UITapGestureRecognizer()
    private let tapGestureTime = UITapGestureRecognizer()
    private let caloriesView = SortingControlView()
    private let timeView = SortingControlView()

    // MARK: - Public Properties

    var presenter: CategoryPresenterProtocol?

    // MARK: - Private Properties

    private let content: [CellTypes] = [.recipes]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        configureTable()
        configureConstraints()
        configureUI()
        setNavigationItem()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .white
        tapGestureTime.addTarget(self, action: #selector(tagTime))
        tapGestureCalories.addTarget(self, action: #selector(tagCalories))
        caloriesView.addGestureRecognizer(tapGestureCalories)
        timeView.addGestureRecognizer(tapGestureTime)
        caloriesView.changeParameters(title: Constants.calories, image: .stackBlack)
        timeView.changeParameters(title: Constants.time, image: .stackBlack)
    }

    private func setNavigationItem() {
        let arrow = UIBarButtonItem(
            image: .arrow.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: nil,
            action: nil
        )
        navigationItem.leftBarButtonItem = arrow
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    private func addSubview() {
        let subviews = [
            tableView,
            searhBar,
            caloriesView,
            timeView
        ]

        view.addSubviews(subviews)
        UIView.doNotTAMIC(for: subviews)
    }

    private func configureTable() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.description())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        configureTableViewConstraits()
    }

    private func configureTableViewConstraits() {
        [
            tableView.topAnchor.constraint(equalTo: caloriesView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].activate()
    }

    private func configureConstraints() {
        setupSearhBarConstraints()
        setupViewConstraints()
    }

    private func setupSearhBarConstraints() {
        [
            searhBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searhBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searhBar.widthAnchor.constraint(equalToConstant: 348),
            searhBar.heightAnchor.constraint(equalToConstant: 36)
        ].activate()
    }

    private func setupViewConstraints() {
        [
            caloriesView.topAnchor.constraint(equalTo: searhBar.bottomAnchor, constant: 20),
            caloriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            caloriesView.widthAnchor.constraint(equalToConstant: 112),
            caloriesView.heightAnchor.constraint(equalToConstant: 36),

            timeView.topAnchor.constraint(equalTo: searhBar.bottomAnchor, constant: 20),
            timeView.leadingAnchor.constraint(equalTo: caloriesView.trailingAnchor, constant: 11),
            timeView.widthAnchor.constraint(equalToConstant: 90),
            timeView.heightAnchor.constraint(equalToConstant: 36)
        ].activate()
    }

    @objc private func tagCalories() {
        presenter?.changesCaloriesSortingStatus()
    }

    @objc private func tagTime() {
        presenter?.changesTimeSortingStatus()
    }
}

extension CategoryView: CategoryViewProtocol {
    func changesTimeSortingStatus(condition: Condition) {
        switch condition {
        case .notPressed:
            timeView.backgroundColor = .recipeView
            timeView.changeParameters(title: Constants.time, image: .stackBlack)
        case .sortingMore:
            timeView.backgroundColor = .accent
            timeView.changeParameters(title: Constants.time, image: .stackWhite)
        case .sortingSmaller:

            if let image: CGImage = UIImage.stackWhite.cgImage {
                let newImage = UIImage(cgImage: image, scale: 1, orientation: .downMirrored)
                timeView.backgroundColor = .accent
                timeView.changeParameters(
                    title: Constants.time,
                    image: newImage
                )
            }
        }
    }

    func changesCaloriesSortingStatus(condition: Condition) {
        switch condition {
        case .notPressed:
            caloriesView.backgroundColor = .recipeView
            caloriesView.changeParameters(title: Constants.calories, image: .stackBlack)
        case .sortingMore:
            caloriesView.backgroundColor = .accent
            caloriesView.changeParameters(title: Constants.calories, image: .stackWhite)
        case .sortingSmaller:

            if let image: CGImage = UIImage.stackWhite.cgImage {
                let newImage = UIImage(cgImage: image, scale: 1, orientation: .downMirrored)
                caloriesView.backgroundColor = .accent
                caloriesView.changeParameters(
                    title: Constants.calories,
                    image: newImage
                )
            }
        }
    }
}

extension CategoryView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        content.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.category.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = content[indexPath.section]
        switch items {
        case .recipes:
            guard let category = presenter?.category,
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: TableViewCell.description(),
                      for: indexPath
                  ) as? TableViewCell
            else { return UITableViewCell() }
            cell.setupCell(category: category[indexPath.row])
            return cell
        }
    }
}
