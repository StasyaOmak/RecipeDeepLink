// DishInfoCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с общей информацией о блюде
final class DishInfoCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let dishImageViewCornerRadiusToHeightRatio = 0.08
    }

    // MARK: - Visual Components

    private let dishNameLabel = {
        let label = UILabel()
        label.font = .verdanaBold(size: 20)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let dishImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerCurve = .continuous
        return view
    }()

    private let weightView = DishWeightView()
    private let cookingTimeView = DishCookingTimeView()

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
        dishImageView.layer.cornerRadius = dishImageView.bounds.height * Constants
            .dishImageViewCornerRadiusToHeightRatio
    }

    // MARK: - Public Methods

    func configure(with dish: Dish) {
        dishNameLabel.text = dish.name
        dishImageView.image = UIImage(dish.imageName)
        weightView.configure(weight: dish.weight)
        cookingTimeView.configure(cookingTime: dish.cookingTime)
    }

    // MARK: - Private Methods

    private func configureUI() {
        dishImageView.addSubviews(weightView, cookingTimeView)
        contentView.addSubviews(dishNameLabel, dishImageView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: dishNameLabel, dishImageView, weightView, cookingTimeView)
        dishNameLabelConfigureLayout()
        dishImageViewConfigureLayout()
        weightViewConfigureLayout()
        cookingTimeViewConfigureLayout()
    }

    private func dishNameLabelConfigureLayout() {
        [
            dishNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dishNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ].activate()
    }

    private func dishImageViewConfigureLayout() {
        [
            dishImageView.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 20),
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            dishImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            dishImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            dishImageView.heightAnchor.constraint(equalTo: dishImageView.widthAnchor),
        ].activate()
    }

    private func weightViewConfigureLayout() {
        [
            weightView.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 6),
            weightView.trailingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: -6)
        ].activate()
    }

    private func cookingTimeViewConfigureLayout() {
        [
            cookingTimeView.trailingAnchor.constraint(equalTo: dishImageView.trailingAnchor),
            cookingTimeView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor)
        ].activate()
    }
}
