// RecipesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс общения с RecipesView
protocol RecipesViewInput: AnyObject {}

/// Вью экрана списка рецептов
final class RecipesView: UIViewController {
    // MARK: - Public Properties

    var presenter: RecipesPresenterInput?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension RecipesView: RecipesViewInput {}
