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

        let serviceDistributor = createServiceDistributor()
        let moduleBuilder = ModuleBuilder(serviceDistributor: serviceDistributor)
        appCoordinator = AppCoordinator(window: window, builder: moduleBuilder)
        appCoordinator?.start()
    }

    private func createServiceDistributor() -> ServiceDistributorProtocol {
        let coreDataService = CoreDataService()
        let networkService = NetworkService()
        let networkServiceProxy = NetworkServiceProxy(networkService: networkService, coreDataService: coreDataService)
        let imageLoadService = ImageLoadService()
        let imageLoadProxy = ImageLoadProxy(imageLoadService: imageLoadService)

        let serviceDistributor = ServiceDistributor()
        serviceDistributor.registerService(service: coreDataService)
        serviceDistributor.registerService(service: networkService)
        serviceDistributor.registerService(service: networkServiceProxy)
        serviceDistributor.registerService(service: imageLoadService)
        serviceDistributor.registerService(service: imageLoadProxy)
        return serviceDistributor
    }
}
