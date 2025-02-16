// CategoriesView.swift
// Copyright © RoadMap. All rights reserved.

import AdvancedNSAttributedStringPKJ
import UIKit

/// Интерфейс взаимодействия с CategoriesView
protocol CategoriesViewProtocol: AnyObject {}

/// Вью экрана списка категорий
final class CategoriesView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let smallItemsSpacing = 15.0
        static let numberOfSmallItemsInRow = 3.0
        static let numberOfMediumItemsInRow = 2.0
        static let largeItemInset = 40.0
    }

    // MARK: - Visual Components

    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return layout
    }()

    private lazy var collectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.description())
        return collection
    }()

    // MARK: - Public Properties

    var presenter: CategoriesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deselectSelectedItem()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        configureTitleLabel()
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: collectionView)
        [
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].activate()
    }

    private func configureTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.attributedText = Local.CategoriesView.titleText.attributed().withColor(.label)
            .withFont(.verdanaBold(size: 28))
        titleLabel.textAlignment = .left
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func deselectSelectedItem() {
        if let selectedIndex = collectionView.indexPathsForSelectedItems?.first {
            collectionView.deselectItem(at: selectedIndex, animated: false)
        }
    }

    private func getCellSizeClass(forIndex index: Int) -> CategoryCell.SizeClass {
        switch index % 7 {
        case 0, 1:
            .medium
        case 2, 6:
            .large
        default:
            .small
        }
    }
}

extension CategoriesView: CategoriesViewProtocol {}

extension CategoriesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getNumberOfCategories() ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let category = presenter?.getCategory(forIndex: indexPath.item),
              let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: CategoryCell.description(),
                  for: indexPath
              ) as? CategoryCell
        else { return UICollectionViewCell() }

        let cellSizeClass = getCellSizeClass(forIndex: indexPath.item)
        cell.configure(with: category, sizeClass: cellSizeClass)
        return cell
    }
}

extension CategoriesView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let avalibleScreenWidth = UIScreen.main.bounds.width - collectionViewFlowLayout.sectionInset.left * 2
        var size = CGSize(width: 100, height: 100)
        switch getCellSizeClass(forIndex: indexPath.item) {
        case .small:
            let itemSide = (
                avalibleScreenWidth - Constants.smallItemsSpacing * Constants
                    .numberOfSmallItemsInRow - 1.0
            ) / Constants.numberOfSmallItemsInRow
            size = CGSize(width: itemSide, height: itemSide)
        case .medium:
            let itemSide = (avalibleScreenWidth - collectionViewFlowLayout.minimumInteritemSpacing) / Constants
                .numberOfMediumItemsInRow
            size = CGSize(width: itemSide, height: itemSide)
        case .large:
            let itemSide = avalibleScreenWidth - Constants.largeItemInset * 2
            size = CGSize(width: itemSide, height: itemSide)
        }
        return size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCategory(atIndex: indexPath.item)
    }
}
