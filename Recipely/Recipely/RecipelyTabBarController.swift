// RecipelyTabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таб бар всея приложения
final class RecipelyTabBarController: UITabBarController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Private Methods

    private func configure() {
        tabBar.backgroundColor = .systemBackground
        tabBar.layer.shadowOffset.height = -1
        tabBar.layer.shadowRadius = 1
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowColor = UIColor.opaqueSeparator.cgColor
        tabBar.tintColor = .accent
    }
}
