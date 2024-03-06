// BasicDishCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка блюда
class BasicDishCell: UITableViewCell {
    // MARK: - Visual Components

    private let dishImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()

    private let timerImageView = UIImageView(image: .timer)
    private let pizzaImageView = UIImageView(image: .pizza)

    private let dishNameLabel = {
        let label = UILabel()
        label.font = .verdana(size: 14)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let timerLabel = {
        let label = UILabel()
        label.font = .verdana(size: 12)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private let caloriesLabel = {
        let label = UILabel()
        label.font = .verdana(size: 12)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private let recipeView = {
        let view = UIView()
        view.backgroundColor = UIColor.recipeView
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.accent.cgColor
        view.layer.frame = view.layer.frame.insetBy(dx: 1, dy: 1)
        view.layer.cornerCurve = .continuous
        return view
    }()

    private(set) var arrowButton = {
        let button = UIButton()
        button.setImage(.vector, for: .normal)
        return button
    }()

    private var state = DataStatus.noData {
        willSet {
            switch newValue {
            case let .dataLoaded(dish):
                isShimmerAnimationRunning = false
                configureCell(category: dish)
            case .noData:
                isShimmerAnimationRunning = true
            }
        }
    }

    private var isShimmerAnimationRunning = false {
        willSet {
            switch newValue {
            case false:
                shimmerLayers.forEach { $0.removeFromSuperlayer() }
            case true:
                for item in [dishImageView, dishNameLabel, timerLabel, caloriesLabel] {
                    shimmerLayers.append(item.startShimmerAnimation(speed: 3))
                }
            }
        }
    }

    // MARK: - Public Properties

    override var isSelected: Bool {
        willSet {
            recipeView.layer.borderWidth = newValue ? 2 : 0
        }
    }

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

    // MARK: - Life Cycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        switch state {
        case .dataLoaded:
            isShimmerAnimationRunning = false
        case .noData:
            isShimmerAnimationRunning = true
        }
    }
    
    

    // MARK: - Public Methods

    func configure(with state: DataStatus) {
        self.state = state
    }

    func configureCell(category: CategoryDish) {
        dishImageView.image = UIImage(category.nameImage)
        dishNameLabel.text = category.nameDish
        timerLabel.text = "\(category.cookingTime) \(Metrics.minutes.rawValue)"
        caloriesLabel.text = "\(category.numberCalories) \(Metrics.kcal.rawValue)"
    }

    // MARK: - Private Methods

    private func configureUI() {
        selectionStyle = .none
        let subviews = [
            recipeView,
            dishImageView,
            dishNameLabel,
            timerImageView,
            timerLabel,
            pizzaImageView,
            caloriesLabel,
            arrowButton
        ]
        contentView.addSubviews(subviews)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: contentView.subviews)
        configureRecipeViewLayout()
        configureDishImageViewLayout()
        configureNameDishLabelLayout()
        configureTimeImageViewLayout()
        configureTimeLabelLayout()
        configurePizzaImageViewLayout()
        configureCaloriesLabelLayout()
        configureArrowButtonLayout()
    }

    private func configureRecipeViewLayout() {
        [
            recipeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            recipeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeView.heightAnchor.constraint(equalToConstant: 100),
            recipeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ].activate()
    }

    private func configureDishImageViewLayout() {
        [
            dishImageView.topAnchor.constraint(equalTo: recipeView.topAnchor, constant: 10),
            dishImageView.heightAnchor.constraint(equalToConstant: 80),
            dishImageView.widthAnchor.constraint(equalTo: dishImageView.heightAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: recipeView.leadingAnchor, constant: 10),
            dishImageView.bottomAnchor.constraint(equalTo: recipeView.bottomAnchor, constant: -10)
        ].activate()
    }

    private func configureNameDishLabelLayout() {
        [
            dishNameLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 20),
            dishNameLabel.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 12),
            dishNameLabel.trailingAnchor.constraint(equalTo: arrowButton.leadingAnchor),
            dishNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)
        ].activate()
    }

    private func configureTimeImageViewLayout() {
        [
            timerImageView.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 9.88),
            timerImageView.heightAnchor.constraint(equalToConstant: 11.25),
            timerImageView.widthAnchor.constraint(equalToConstant: 11.25),
            timerImageView.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 21.88)
        ].activate()
    }

    private func configureTimeLabelLayout() {
        [
            timerLabel.leadingAnchor.constraint(equalTo: timerImageView.trailingAnchor, constant: 5.88),
            timerLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 8),
            timerLabel.widthAnchor.constraint(equalToConstant: 55),
            timerLabel.heightAnchor.constraint(equalToConstant: 15)
        ].activate()
    }

    private func configurePizzaImageViewLayout() {
        [
            pizzaImageView.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 9.88),
            pizzaImageView.heightAnchor.constraint(equalToConstant: 11.25),
            pizzaImageView.widthAnchor.constraint(equalToConstant: 11.25),
            pizzaImageView.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 10),
        ].activate()
    }

    private func configureCaloriesLabelLayout() {
        [
            caloriesLabel.leadingAnchor.constraint(equalTo: pizzaImageView.trailingAnchor, constant: 5.88),
            caloriesLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 8),
            caloriesLabel.widthAnchor.constraint(equalToConstant: 72),
            caloriesLabel.heightAnchor.constraint(equalToConstant: 15)
        ].activate()
    }

    private func configureArrowButtonLayout() {
        [
            arrowButton.topAnchor.constraint(equalTo: recipeView.topAnchor, constant: 39.58),
            arrowButton.heightAnchor.constraint(equalToConstant: 20),
            arrowButton.widthAnchor.constraint(equalToConstant: 12.35),
            arrowButton.trailingAnchor.constraint(equalTo: recipeView.trailingAnchor, constant: -15.42)
        ].activate()
    }
}
