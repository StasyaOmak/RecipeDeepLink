// BasicDishShimmerCell .swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка шимер для DishCell
class DishShimmerCell: UITableViewCell {
    // MARK: - Visual Components

    private let backView = UIView()
    private let dishImageShimmerView = UIView()
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
        dishImageShimmerView.startShimmerAnimation(speed: 3)
        dishNameShimmerView.startShimmerAnimation(speed: 3)
        timerShimmerView.startShimmerAnimation(speed: 3)
        caloriesShimmerView.startShimmerAnimation(speed: 3)
    }

    // MARK: - Private Methods

    private func configureUI() {
        selectionStyle = .none
        backgroundView = UIView()
        let subviews = [
            backView,
            dishImageShimmerView,
            dishNameShimmerView,
            timerShimmerView,
            caloriesShimmerView
        ]
        contentView.addSubviews(subviews)
        dishImageShimmerView.layer.cornerRadius = 12
        backView.layer.cornerRadius = 12
        backView.backgroundColor = .recipeView
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: contentView.subviews)
        backViewConfigureLayout()
        dishImageShimmerViewConfigureLayout()
        dishNameShimmerViewConfigureLayout()
        timerShimmerViewConfigureLayout()
        caloriesShimmerViewConfigureLayout()
    }

    private func backViewConfigureLayout() {
        [
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            backView.heightAnchor.constraint(equalToConstant: 100),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ].activate()
    }

    private func dishImageShimmerViewConfigureLayout() {
        [
            dishImageShimmerView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            dishImageShimmerView.widthAnchor.constraint(equalTo: dishImageShimmerView.heightAnchor),
            dishImageShimmerView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            dishImageShimmerView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10)
        ].activate()
    }

    private func dishNameShimmerViewConfigureLayout() {
        [
            dishNameShimmerView.leadingAnchor.constraint(equalTo: dishImageShimmerView.trailingAnchor, constant: 20),
            dishNameShimmerView.topAnchor.constraint(equalTo: dishImageShimmerView.topAnchor, constant: 12),
            dishNameShimmerView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -43),
            dishNameShimmerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)
        ].activate()
    }

    private func timerShimmerViewConfigureLayout() {
        [
            timerShimmerView.leadingAnchor.constraint(equalTo: dishImageShimmerView.trailingAnchor, constant: 20),
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
