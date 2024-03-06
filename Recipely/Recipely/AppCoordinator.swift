// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Основной координатор приложения
final class AppCoordinator: BaseCoordinator {
    // MARK: - Private Properties

    private var builder: Builder

    // MARK: - Visual Components

    private var window: UIWindow?

    // MARK: - Initializers

    init(window: UIWindow?, builder: Builder) {
        self.window = window
        self.builder = builder
    }

    // MARK: - Public Methods

    override func start() {
        let navigationController = UINavigationController()
        let authCoordinator = AuthCoordinator(rootController: navigationController, builder: builder)
        add(coordinator: authCoordinator)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        authCoordinator.start()
    }

    override func setAsRoot(_ viewController: UIViewController) {
        guard let window,
              let snapshot = window.snapshotView(afterScreenUpdates: true)
        else { return }

        viewController.view.addSubview(snapshot)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 0.4,
            options: [.curveEaseInOut],
            animations: {
                snapshot.transform = CGAffineTransform(translationX: 0, y: snapshot.frame.height)
            },
            completion: { _ in
                snapshot.removeFromSuperview()
            }
        )
    }

    func showTabBarModule() {
        let tabBarController = builder.buildRecipelyTabBarController()
        let tabBarCoordinator = RecipelyTabBarCoordinator(rootController: tabBarController, builder: builder)
        add(coordinator: tabBarCoordinator)
        setAsRoot(tabBarController)
        tabBarCoordinator.start()
    }

    override func childDidFinish(_ child: Coordinator) {
        super.childDidFinish(child)
        guard child is AuthCoordinator else { return }
        showTabBarModule()
    }
}
