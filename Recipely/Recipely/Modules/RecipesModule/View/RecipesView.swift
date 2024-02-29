// RecipesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с RecipesView
protocol RecipesViewProtocol: AnyObject {}

/// Вью экрана списка рецептов
final class RecipesView: UIViewController {
    // MARK: - Public Properties

    var presenter: RecipesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension RecipesView: RecipesViewProtocol {}
