// FavouritesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка рецепта которая добавлена в избранное
final class FavouritesCell: RecipeCell {
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        arrowButton.isHidden = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        arrowButton.isHidden = true
    }
}
