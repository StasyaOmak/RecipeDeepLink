// DishKBZHUCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с информацией о КБЖУ блюда
final class DishKBZHUCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let enercText = "Enerc kcal"
        static let carbohydratesText = "Carbohydrates"
        static let fatsText = "Fats"
        static let proteinsText = "Proteins"
    }

    // MARK: - Visual Components

    private let enercView = NutrientView(metrics: .kcal)
    private let carbohydratesView = NutrientView(metrics: .gram)
    private let fatsView = NutrientView(metrics: .gram)
    private let proteinsView = NutrientView(metrics: .gram)

    private lazy var nutrientsStackView = {
        let stack = UIStackView(arrangedSubviews: [
            self.enercView,
            self.carbohydratesView,
            self.fatsView,
            self.proteinsView
        ])
        stack.spacing = 6
        stack.distribution = .fillEqually
        return stack
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func configure(with dish: Dish) {
        enercView.configure(title: Constants.enercText, value: dish.calories)
        carbohydratesView.configure(title: Constants.carbohydratesText, value: dish.carbohydrates)
        fatsView.configure(title: Constants.fatsText, value: dish.fats)
        proteinsView.configure(title: Constants.proteinsText, value: dish.proteins)
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubviews(nutrientsStackView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: nutrientsStackView)
        [
            nutrientsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nutrientsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nutrientsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nutrientsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ].activate()
    }
}
