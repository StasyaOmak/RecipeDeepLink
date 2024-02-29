// TableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рецептами
class TableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let minutes = "min"
        static let calories = "kkal"
    }

    // MARK: - Visual Components

    private var dishImageView = UIImageView()
    private var timerImageView = UIImageView(image: .timer)
    private var pizzaImageView = UIImageView(image: .pizza)

    private let namedishLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(14)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let timetLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(12)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private let caloriesLabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(12)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let arrowButton = {
        let button = UIButton()
        button.setImage(.vector, for: .normal)
        return button
    }()

    private let recipeView = {
        let view = UIView()
        view.backgroundColor = UIColor.recipeView
        view.layer.cornerRadius = 12
        return view
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public Methods

    func setupCell(category: CategoryProtocol) {
        dishImageView.image = UIImage(named: category.nameImage)
        namedishLabel.text = category.nameDish
        timetLabel.text = "\(category.cookingTime) \(Constants.minutes)"
        caloriesLabel.text = "\(category.numberCalories) \(Constants.calories)"
    }

    // MARK: - Private Methods

    private func setupUI() {
        let subviews = [
            recipeView,
            namedishLabel,
            timetLabel,
            caloriesLabel,
            arrowButton,
            dishImageView,
            timerImageView,
            pizzaImageView
        ]

        contentView.addSubviews(subviews)
        UIView.doNotTAMIC(for: subviews)
    }

    private func configureLayout() {
        configureImageViewLayout()
        configureButtonLayout()
        configureLabelLayout()
        configureViewLayout()
    }

    private func configureViewLayout() {
        [
            recipeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            recipeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeView.heightAnchor.constraint(equalToConstant: 100),
            recipeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ].activate()
    }

    private func configureLabelLayout() {
        [
            namedishLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 20),
            namedishLabel.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 12),
            namedishLabel.widthAnchor.constraint(equalToConstant: 197),

            timetLabel.leadingAnchor.constraint(equalTo: timerImageView.trailingAnchor, constant: 5.88),
            timetLabel.topAnchor.constraint(equalTo: namedishLabel.bottomAnchor, constant: 8),
            timetLabel.widthAnchor.constraint(equalToConstant: 55),
            timetLabel.heightAnchor.constraint(equalToConstant: 15),

            caloriesLabel.leadingAnchor.constraint(equalTo: pizzaImageView.trailingAnchor, constant: 5.88),
            caloriesLabel.topAnchor.constraint(equalTo: namedishLabel.bottomAnchor, constant: 8),
            caloriesLabel.widthAnchor.constraint(equalToConstant: 72),
            caloriesLabel.heightAnchor.constraint(equalToConstant: 15)
        ].activate()
    }

    private func configureImageViewLayout() {
        [
            dishImageView.topAnchor.constraint(equalTo: recipeView.topAnchor, constant: 10),
            dishImageView.heightAnchor.constraint(equalToConstant: 80),
            dishImageView.widthAnchor.constraint(equalToConstant: 80),
            dishImageView.leadingAnchor.constraint(equalTo: recipeView.leadingAnchor, constant: 10),

            timerImageView.topAnchor.constraint(equalTo: namedishLabel.bottomAnchor, constant: 9.88),
            timerImageView.heightAnchor.constraint(equalToConstant: 11.25),
            timerImageView.widthAnchor.constraint(equalToConstant: 11.25),
            timerImageView.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 21.88),

            pizzaImageView.topAnchor.constraint(equalTo: namedishLabel.bottomAnchor, constant: 9.88),
            pizzaImageView.heightAnchor.constraint(equalToConstant: 11.25),
            pizzaImageView.widthAnchor.constraint(equalToConstant: 11.25),
            pizzaImageView.leadingAnchor.constraint(equalTo: timetLabel.trailingAnchor, constant: 10),

        ].activate()
    }

    private func configureButtonLayout() {
        [
            arrowButton.topAnchor.constraint(equalTo: recipeView.topAnchor, constant: 39.58),
            arrowButton.heightAnchor.constraint(equalToConstant: 20),
            arrowButton.widthAnchor.constraint(equalToConstant: 12.35),
            arrowButton.trailingAnchor.constraint(equalTo: recipeView.trailingAnchor, constant: -15.42)

        ].activate()
    }
}
