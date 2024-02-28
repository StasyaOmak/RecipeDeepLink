// FavouritesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с FavouritesView
protocol FavouritesViewProtocol: AnyObject {}

/// Вью экрана сохранненных рецептов
final class FavouritesView: UIViewController {
    // MARK: - Public Properties

    var presenter: FavouritesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension FavouritesView: FavouritesViewProtocol {}
