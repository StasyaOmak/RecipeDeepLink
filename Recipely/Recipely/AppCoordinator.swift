// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Keychain
import UIKit

/// Основной координатор приложения
final class AppCoordinator: BaseCoordinator {
    var tabBarController: RecipelyTabBarController?
    var navigationController: UINavigationController?

    // MARK: - Private Properties

    private var builder: Builder

    // MARK: - Visual Components

    private var window: UIWindow?

    // MARK: - Initializers

    init(window: UIWindow?, builder: Builder, tabBarController: RecipelyTabBarController? = nil) {
        self.window = window
        self.builder = builder
        self.tabBarController = tabBarController
    }

    func openFavoritesTab() {
        showTabBarModule()
        tabBarController?.selectedIndex = 1
    }

    func openProfileTab() {
        showTabBarModule()
        tabBarController?.selectedIndex = 2
    }

    func editProfileTitle(navigationTitle: String) {
        openProfileTab()
        guard let navigationViewController = tabBarController?.children[2] as? UINavigationController,
              let profileView = navigationViewController.topViewController as? ProfileView
        else { return }
        profileView.configureTitleLabel(attributedText: navigationTitle)
    }

    // MARK: - Public Methods

    override func start() {
        showAuthModule()
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

    override func childDidFinish(_ child: Coordinator) {
        super.childDidFinish(child)
        switch child {
        case is AuthCoordinator:
            showTabBarModule()
        case is RecipelyTabBarCoordinator:
            showAuthModule()
        default:
            break
        }
    }

    // MARK: - Private Methods

    private func showTabBarModule() {
        self.tabBarController = builder.buildRecipelyTabBarController()
        guard let tabBarController = tabBarController else { return }
        let tabBarCoordinator = RecipelyTabBarCoordinator(rootController: tabBarController, builder: builder)
        add(coordinator: tabBarCoordinator)
        setAsRoot(tabBarController)
        tabBarCoordinator.start()
    }

    private func showAuthModule() {
        self.navigationController = UINavigationController()
        guard let navigationController = navigationController else { return }
        let authCoordinator = AuthCoordinator(rootController: navigationController, builder: builder)
        add(coordinator: authCoordinator)
        setAsRoot(navigationController)
        authCoordinator.start()
    }
}
