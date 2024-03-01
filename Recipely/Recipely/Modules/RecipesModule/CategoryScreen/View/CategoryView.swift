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
class CategoryView: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Types

    private enum CellTypes {
        /// Тип ячейки рецепта
        case recipes
    }

    // MARK: - Constants

    private enum Constants {
        static let caloriesText = "Calories"
        static let timeText = "Time"
        static let fishText = "Fish"
        static let placeholderText = "Search recipes"
    }

    // MARK: - Visual Components

    private let searhBar = {
        let searhBar = UISearchBar()
        searhBar.searchTextField.borderStyle = .none
        searhBar.searchBarStyle = .minimal
        searhBar.searchTextField.backgroundColor = UIColor.searhBar
        searhBar.searchTextField.layer.cornerRadius = 12
        searhBar.placeholder = Constants.placeholderText
        searhBar.translatesAutoresizingMaskIntoConstraints = false
        return searhBar
    }()

    private lazy var caloriesView = {
        let view = SortingControlView()
        view.tag = 0
        view.changeParameters(title: Constants.caloriesText, image: .stackBlack)
        let tapGestureCalories = UITapGestureRecognizer(target: self, action: #selector(sortControllTapped(_:)))
        view.addGestureRecognizer(tapGestureCalories)
        return view
    }()

    private lazy var timeView = {
        let view = SortingControlView()
        view.tag = 1
        view.changeParameters(title: Constants.timeText, image: .stackBlack)
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
        table.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.description())
        return table
    }()

    // MARK: - Public Properties

    var presenter: CategoryPresenterProtocol?

    // MARK: - Private Properties

    private let content: [CellTypes] = [.recipes]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
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
            image: .arrow.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: nil,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        let titleLabel = UILabel()
        let title = presenter?.getTitle() ?? ""
        titleLabel.attributedText = title.attributed().withColor(.label)
            .withFont(.verdanaBold?.withSize(28))
        titleLabel.textAlignment = .left
        navigationItem.leftBarButtonItems?.append(UIBarButtonItem(customView: titleLabel))
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

extension CategoryView: CategoryViewProtocol {
    func changesTimeSortingStatus(condition: Condition) {
        switch condition {
        case .notPressed:
            timeView.backgroundColor = .recipeView
            timeView.changeParameters(title: Constants.timeText, image: .stackBlack)
        case .sortingMore:
            timeView.backgroundColor = .accent
            timeView.changeParameters(title: Constants.timeText, image: .stackWhite)
        case .sortingSmaller:
            if let image: CGImage = UIImage.stackWhite.cgImage {
                let newImage = UIImage(cgImage: image, scale: 1, orientation: .downMirrored)
                timeView.backgroundColor = .accent
                timeView.changeParameters(
                    title: Constants.timeText,
                    image: newImage
                )
            }
        }
    }

    func changesCaloriesSortingStatus(condition: Condition) {
        switch condition {
        case .notPressed:
            caloriesView.backgroundColor = .recipeView
            caloriesView.changeParameters(title: Constants.caloriesText, image: .stackBlack)
        case .sortingMore:
            caloriesView.backgroundColor = .accent
            caloriesView.changeParameters(title: Constants.caloriesText, image: .stackWhite)
        case .sortingSmaller:
            if let image: CGImage = UIImage.stackWhite.cgImage {
                let newImage = UIImage(cgImage: image, scale: 1, orientation: .downMirrored)
                caloriesView.backgroundColor = .accent
                caloriesView.changeParameters(
                    title: Constants.caloriesText,
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
        presenter?.recipes.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = content[indexPath.section]
        switch items {
        case .recipes:
            guard let category = presenter?.recipes,
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: RecipeCell.description(),
                      for: indexPath
                  ) as? RecipeCell
            else { return UITableViewCell() }
            cell.configureCell(category: category[indexPath.row])
            return cell
        }
    }
}

extension CategoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = true
    }

    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        return indexPath
    }
}
