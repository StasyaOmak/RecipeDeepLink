// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import Swinject
import UIKit

// swiftlint:disable all

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        createWindow(with: scene)
    }

    private func createWindow(with scene: UIScene) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)

        let serviceDistributor = createServiceDistributor()
        let moduleBuilder = ModuleBuilder(serviceDistributor: serviceDistributor)
        appCoordinator = AppCoordinator(window: window, builder: moduleBuilder)
        appCoordinator?.start()
    }

    private func configureInitialWindow(scene: UIScene, handler: (AppCoordinator?) -> ()) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()

        let serviceDistributor = createServiceDistributor()
        let moduleBuilder = ModuleBuilder(serviceDistributor: serviceDistributor)
        appCoordinator = AppCoordinator(window: window, builder: moduleBuilder)
        handler(appCoordinator)
    }

    private func createServiceDistributor() -> Container {
        let container = Container()
        container.register(CoreDataService.self) { _ in CoreDataService() }.inObjectScope(.container)
        container.register(NetworkService.self) { _ in NetworkService() }.inObjectScope(.container)
        container.register(ImageLoadService.self) { _ in ImageLoadService() }.inObjectScope(.container)

        container.register(NetworkServiceProxy.self) { resolver in
            NetworkServiceProxy(
                networkService: resolver.resolve(NetworkService.self),
                coreDataService: resolver.resolve(CoreDataService.self)
            )
        }.inObjectScope(.container)
        container.register(ImageLoadProxy.self) { resolver in
            ImageLoadProxy(imageLoadService: resolver.resolve(ImageLoadService.self))
        }.inObjectScope(.container)

        return container
    }

    // recipes://
    // recipes://favorites
    // recipes://profile
    // recipes://change_profile?title=anastasiya
    // xcrun simctl openurl booted "recipes://change_profile?title=anastasiya"
    // xcrun simctl openurl booted "recipes://favorites"
    // xcrun simctl openurl booted "recipes://profile"

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let firstURL = URLContexts.first?.url,
              let components = URLComponents(url: firstURL, resolvingAgainstBaseURL: true) else { return }
        let host = components.host

        switch host {
        case "favorites":
            configureInitialWindow(scene: scene) { appCoordinator in
                appCoordinator?.openFavoritesTab()
            }
        case "profile":
            configureInitialWindow(scene: scene) { appCoordinator in
                appCoordinator?.openProfileTab()
            }
        case "change_profile":
            let queryItems = components.queryItems
            let firstQuery = queryItems?.first(where: { $0.name == "title" })
            switch firstQuery?.value {
            case "anastasiya":
                configureInitialWindow(scene: scene) { appCoordinator in
                    appCoordinator?.editProfileTitle(navigationTitle: "Sdohni ili Umri")
                }
            default:
                configureInitialWindow(scene: scene) { appCoordinator in
                    appCoordinator?.editProfileTitle(navigationTitle: "Try Again")
                }
            }
        default:
            print("Deep Likl does not exist")
        }
    }
}

// swiftlint:enable all
