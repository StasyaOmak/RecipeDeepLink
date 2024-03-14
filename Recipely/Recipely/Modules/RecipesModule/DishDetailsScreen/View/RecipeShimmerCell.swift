// RecipeShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка шимер для DishCell
class RecipeShimmerCell: UITableViewCell {
    // MARK: - Visual Components

    private let titleLabelShimmerView = UIView()
    private let recipeImageShimmerView = UIView()
    private let kcalShimmerView = UIView()

    private let dishNameShimmerView = UIView()
    private let timerShimmerView = UIView()
    private let caloriesShimmerView = UIView()

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
        dishNameShimmerView.startShimmerAnimation(speed: 3)
        timerShimmerView.startShimmerAnimation(speed: 3)
        caloriesShimmerView.startShimmerAnimation(speed: 3)
    }

    // MARK: - Private Methods

    private func configureUI() {
        selectionStyle = .none
        backgroundView = UIView()
        let subviews = [
            titleLabelShimmerView,
            recipeImageShimmerView,
            kcalShimmerView,

            dishNameShimmerView,
            timerShimmerView,
            caloriesShimmerView
        ]
        contentView.addSubviews(subviews)
        recipeImageShimmerView.layer.cornerRadius = 12
        titleLabelShimmerView.layer.cornerRadius = 12
        titleLabelShimmerView.backgroundColor = .recipeView
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: contentView.subviews)
        titleLabelShimmerViewConfigureLayout()
        dishImageShimmerViewConfigureLayout()
        dishNameShimmerViewConfigureLayout()
        kcalShimmerViewConfigureLayout()

        timerShimmerViewConfigureLayout()
        caloriesShimmerViewConfigureLayout()
    }

    private func titleLabelShimmerViewConfigureLayout() {
        [
            titleLabelShimmerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabelShimmerView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ].activate()
    }

    private func dishImageShimmerViewConfigureLayout() {
        [
            recipeImageShimmerView.topAnchor.constraint(equalTo: titleLabelShimmerView.bottomAnchor, constant: 20),
            recipeImageShimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
//            recipeImageShimmerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            recipeImageShimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            recipeImageShimmerView.heightAnchor.constraint(equalTo: recipeImageShimmerView.widthAnchor),
        ].activate()
    }

    private func kcalShimmerViewConfigureLayout() {
        [
            kcalShimmerView.topAnchor.constraint(equalTo: recipeImageShimmerView.bottomAnchor, constant: 20),
            kcalShimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            kcalShimmerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            kcalShimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            kcalShimmerView.heightAnchor.constraint(equalTo: recipeImageShimmerView.widthAnchor),
        ].activate()
    }

    private func dishNameShimmerViewConfigureLayout() {
        [
            dishNameShimmerView.leadingAnchor.constraint(equalTo: recipeImageShimmerView.trailingAnchor, constant: 20),
            dishNameShimmerView.topAnchor.constraint(equalTo: recipeImageShimmerView.topAnchor, constant: 12),
            dishNameShimmerView.trailingAnchor.constraint(equalTo: titleLabelShimmerView.trailingAnchor, constant: -43),
            dishNameShimmerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)
        ].activate()
    }

    private func timerShimmerViewConfigureLayout() {
        [
            timerShimmerView.leadingAnchor.constraint(equalTo: recipeImageShimmerView.trailingAnchor, constant: 20),
            timerShimmerView.topAnchor.constraint(equalTo: dishNameShimmerView.bottomAnchor, constant: 8),
            timerShimmerView.widthAnchor.constraint(equalToConstant: 74),
            timerShimmerView.heightAnchor.constraint(equalToConstant: 15)
        ].activate()
    }

    private func caloriesShimmerViewConfigureLayout() {
        [
            caloriesShimmerView.leadingAnchor.constraint(equalTo: timerShimmerView.trailingAnchor, constant: 10),
            caloriesShimmerView.topAnchor.constraint(equalTo: dishNameShimmerView.bottomAnchor, constant: 8),
            caloriesShimmerView.widthAnchor.constraint(equalToConstant: 91),
            caloriesShimmerView.heightAnchor.constraint(equalToConstant: 15)
        ].activate()
    }
}
