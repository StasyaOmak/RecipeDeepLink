// RecipeShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка шимер для DishCell
class RecipeShimmerCell: UITableViewCell {
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
            nutrientsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
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
        view.widthAnchor.constraint(equalToConstant: 74).activate()
        return view
    }
}

// #Preview {
//    class Coordinator: RecipesCoordinatorProtocol {
//        func showCategoryDishesScreen(withCategory category: DishCategory) {}
//
//        func showDishDetailsScreen(with dish: String) {}
//    }
//
//    let view = ModuleBuilder(serviceDistributor: ServiceDistributor()).buildDishDetailsScreen(
//        coordinator: Coordinator(),
//        uri: "https://edamam-product-images.s3.amazonaws.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEH0aCXVzLWVhc3QtMSJIMEYCIQCrrNAG4%2BDaUjcBYPTmprJYh7w9cDS1lkx3YqjhWXD20wIhAOrEV%2BFkWUAJj%2FmwdH38YHs8rJ5dTdAwnYxB87RjBm6lKsIFCIb%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2IgxxWo1szYeePEMyxqgqlgXqhgc36bMkBL3cEV2U95h%2FMU8xjKEkS%2BXidIxnd%2BluchSf4Io6neKmJPTCmkPl605tcdAePNXE60iZ5tKaiBcFziRVq%2B72WL2tneN%2B2SlIm6aWKD1p4%2Fk%2BlDHwKjb5YtR3uU%2BDI6mlVHhjo9DM4YJCRarY%2FYBG8q4iuHNY9ud8Zuiay8jYeXTC3Tl5cWLbY6eq7AOKJbwmkH5tspyeQZRvxHG3KbJNQMNRKv4vcGMK%2FnmvAoBZk4JixikXDG%2Fp5i4x6cx9qishvDt3YaGtArcHuLCtzH4fq8VJKLQJUuT2x1V3FUe4zBePU4NShPXCJS%2FvCBpnL2NKzme5t4iQgZmX8YtdMKtFb2BiZyQ%2BU5CAfIHAkxWY%2BRZosXe1WFvKa0dQweK5omTuSJAiSj0oXv8ckf1UDzFBFUOcElEZpw7ut6bC4ZCOW4wBT2YarV2tGF7Q5uSBsiJUhbFokz7MQfGDl3B26y6hwYSlqmIPDBRhKhbeNwC9VxcIW4Vn31MYOkOVk1tR6xsvabJcutUuX477TySLgQFwp22Jtyxq4jlJm6a%2FzkZ4gCbAAU8RIeqTF1YK4%2Bmu%2FGBpyQz%2FJIi8K74Dt2NRJjWKtztpMGQYvjpS0w96C%2BiRSk%2FNHhXC%2FBv5uXuGB0AMKB%2FYKWPzWhQQ4vo5faZden9yIRr3ee0Zk0Ai%2BBXUDMJhl98542dhRElwJSg%2BDDhdixjfaaY2jFfcbDM%2FmoMZmWeOUORwzxFn38Xy2fxEzXrxDK5vHZlNU15BKyZlxNc8wJHTdpAG0J%2Fs3AORKq%2BC5r92mn8t3WEAf9RAras3FADO9OgyhQ6zlWOSq3hUlyvTDR4%2FHwgdricvjjQZY7T0uTxj8sP8UKM8a8GK0Ss4d8wb8DC0ms%2BvBjqwAYurajbELWgyRqlJI5T%2FSNLwc8LVDWoe2%2FN2to1uIy33mfKg5%2F6heyCvYil0ZK5BXWJV4pfnfOD2epL8mCcNyvKxMytyuMc%2FINEnPy4KWga8MrK%2FRu7LemKG7nA4ZoGF0YYoKxLHu1XeAcb8IvFUMaBaF3%2BuNX0UwRC9XiGfPJWB1uEL%2FzJZ7ow9WeNDLJS2X3FOs%2BJ9PYENd8aqZlWnTPjs2oV3KScdCEz6oYx2g5LE&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240315T051539Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFGWLJDGVR%2F20240315%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=b7709afdc248a5f85f6b0497ff4bc292dfa6c62c8a3f3149bb2e3fd9e8afc8d1"
//    )
//    return view
// }
