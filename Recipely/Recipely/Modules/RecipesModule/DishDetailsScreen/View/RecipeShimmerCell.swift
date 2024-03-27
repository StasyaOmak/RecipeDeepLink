// RecipeShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка шимер для DishCell
final class RecipeShimmerCell: UITableViewCell {
    // MARK: - Visual Components

    private let titleShimmerView = UIView()
    private let dishImageShimmerView = UIView()
    private let recipeShimmerView = UIView()

    private lazy var nutrientsStackView = {
        let stack = UIStackView(arrangedSubviews: [
            createNutrientShimmerView(),
            createNutrientShimmerView(),
            createNutrientShimmerView(),
            createNutrientShimmerView()
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

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        dishImageShimmerView.startShimmerAnimation(speed: 3)
        titleShimmerView.startShimmerAnimation(speed: 3)
        nutrientsStackView.arrangedSubviews.forEach { $0.startShimmerAnimation(speed: 3) }
        recipeShimmerView.startShimmerAnimation(speed: 3)
    }

    // MARK: - Private Methods

    private func configureUI() {
        selectionStyle = .none
        contentView.addSubviews(titleShimmerView, dishImageShimmerView, nutrientsStackView, recipeShimmerView)
        titleShimmerView.layer.cornerRadius = 4
        dishImageShimmerView.layer.cornerRadius = 12
        recipeShimmerView.layer.cornerRadius = 24
        titleShimmerView.layer.cornerCurve = .continuous
        dishImageShimmerView.layer.cornerCurve = .continuous
        recipeShimmerView.layer.cornerCurve = .continuous
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
            titleShimmerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleShimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleShimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleShimmerView.heightAnchor.constraint(equalToConstant: 24)
        ].activate()
    }

    private func recipeImageShimmerViewConfigureLayout() {
        [
            dishImageShimmerView.topAnchor.constraint(equalTo: titleShimmerView.bottomAnchor, constant: 20),
            dishImageShimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            dishImageShimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            dishImageShimmerView.heightAnchor.constraint(equalTo: dishImageShimmerView.widthAnchor),
        ].activate()
    }

    private func nutrientsStackViewConfigureLayout() {
        [
            nutrientsStackView.topAnchor.constraint(equalTo: dishImageShimmerView.bottomAnchor, constant: 20),
            nutrientsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nutrientsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ].activate()
    }

    private func recipeLabelShimmerViewConfigureLayout() {
        [
            recipeShimmerView.topAnchor.constraint(equalTo: nutrientsStackView.bottomAnchor, constant: 20),
            recipeShimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeShimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeShimmerView.heightAnchor.constraint(equalToConstant: 300),
            recipeShimmerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].activate()
    }

    private func createNutrientShimmerView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        view.heightAnchor.constraint(equalToConstant: 53).activate()
        view.widthAnchor.constraint(lessThanOrEqualToConstant: 74).priority(.defaultLow).activate()
        return view
    }
}
