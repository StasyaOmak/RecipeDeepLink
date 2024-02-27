// RecipesCoordinator copy.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RecipesCoordinatorProtocol: AnyObject {}

final class RecipesCoordinator: BaseCoordinator {
    private var rootController: UINavigationController

    init(rootController: UINavigationController) {
        self.rootController = rootController
    }

    override func start() {
        let recipesScreen = ModuleBuilder.buildRecipesScreen()
        (recipesScreen.presenter as? RecipesPresenterProtocol)?.injectCoordinator(self)
        rootController.setViewControllers([recipesScreen], animated: false)
    }
}

extension RecipesCoordinator: RecipesCoordinatorProtocol {}
