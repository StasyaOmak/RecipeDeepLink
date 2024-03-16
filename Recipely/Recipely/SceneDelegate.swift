// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

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

        let serviceDistributor = ServiceDistributor()
        let dataStrore = NetworkServiceProxy(networkService: NetworkService(), coreDataService: CoreDataService())
        serviceDistributor.registerService(service: dataStrore)
        serviceDistributor.registerService(service: ImageLoadProxy(imageLoadService: ImageLoadService()))

        let moduleBuilder = ModuleBuilder(serviceDistributor: serviceDistributor)
        appCoordinator = AppCoordinator(window: window, builder: moduleBuilder)
        appCoordinator?.start()
    }
}
