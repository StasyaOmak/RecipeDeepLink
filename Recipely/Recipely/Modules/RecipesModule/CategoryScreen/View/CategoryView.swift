// CategoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс взаимодействия с CategoryView
protocol CategoryViewProtocol: AnyObject {}

/// Вью экрана категория
class CategoryView: UIViewController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

    // MARK: - Public Properties

    var presenter: CategoryPresenterProtocol?
}

extension CategoryView: CategoryViewProtocol {}
