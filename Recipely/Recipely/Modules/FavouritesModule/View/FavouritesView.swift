// FavouritesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс общения с FavouritesView
protocol FavouritesViewInput: AnyObject {}

/// Вью экрана сохранненных рецептов
final class FavouritesView: UIViewController {
    // MARK: - Public Properties

    var presenter: FavouritesPresenterInput?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension FavouritesView: FavouritesViewInput {}
