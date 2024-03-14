// RecipeShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка шимер для DishCell
class RecipeShimmerCell: UITableViewCell {
    // MARK: - Visual Components

    private let titleLabelShimmerView = UIView()
    private let recipeImageShimmerView = UIView()
    private let recipeLabelShimmerView = UIView()

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

    // MARK: - Private Properties

    private var shimmerLayers: [CAGradientLayer] = []

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

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        recipeImageShimmerView.startShimmerAnimation(speed: 3)
        titleLabelShimmerView.startShimmerAnimation(speed: 3)
        nutrientsStackView.startShimmerAnimation(speed: 3)
        recipeLabelShimmerView.startShimmerAnimation(speed: 3)
    }

    // MARK: - Private Methods

    private func configureUI() {
        selectionStyle = .none
        backgroundView = UIView()
        let subviews = [
            titleLabelShimmerView,
            recipeImageShimmerView,
            nutrientsStackView,
            recipeLabelShimmerView
        ]
        contentView.addSubviews(subviews)
        recipeImageShimmerView.layer.cornerRadius = 12
        titleLabelShimmerView.backgroundColor = .recipeView
        recipeLabelShimmerView.layer.cornerRadius = 24
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: contentView.subviews)
        titleLabelShimmerViewConfigureLayout()
        recipeImageShimmerViewConfigureLayout()
        nutrientsStackViewConfigureLayout()
        recipeLabelShimmerViewConfigureLayout()
    }

    private func titleLabelShimmerViewConfigureLayout() {
        [
            titleLabelShimmerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabelShimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabelShimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabelShimmerView.heightAnchor.constraint(equalToConstant: 16)
        ].activate()
    }

    private func recipeImageShimmerViewConfigureLayout() {
        [
            recipeImageShimmerView.topAnchor.constraint(equalTo: titleLabelShimmerView.bottomAnchor, constant: 20),
            recipeImageShimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            recipeImageShimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            recipeImageShimmerView.heightAnchor.constraint(equalTo: recipeImageShimmerView.widthAnchor),
        ].activate()
    }

    private func nutrientsStackViewConfigureLayout() {
        [
            nutrientsStackView.topAnchor.constraint(equalTo: recipeImageShimmerView.bottomAnchor, constant: 20),
            nutrientsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nutrientsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ].activate()
    }

    private func recipeLabelShimmerViewConfigureLayout() {
        [
            recipeLabelShimmerView.topAnchor.constraint(equalTo: nutrientsStackView.bottomAnchor, constant: 20),
            recipeLabelShimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeLabelShimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeLabelShimmerView.heightAnchor.constraint(equalToConstant: 300)
        ].activate()
    }
}
