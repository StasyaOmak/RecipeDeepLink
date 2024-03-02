// RecipeCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рецептом блюда
final class RecipeCell: UITableViewCell {
    // MARK: - Visual Components

    private let recipeLabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .verdana?.withSize(14)
        label.numberOfLines = 0
        return label
    }()

    private let gradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.gridient.cgColor, UIColor.white.cgColor]
        layer.cornerRadius = 24
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return layer
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

    // MARK: - Life Cycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientLayer.frame = rect
    }

    // MARK: - Public Methods

    func configure(with dish: Dish) {
        recipeLabel.text = dish.recipe
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.layer.addSublayer(gradientLayer)
        contentView.addSubviews(recipeLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: recipeLabel)
        [
            recipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            recipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27),
            recipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),
            recipeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ].activate()
    }
}
