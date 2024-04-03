// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import Swinject
import UIKit

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
}
