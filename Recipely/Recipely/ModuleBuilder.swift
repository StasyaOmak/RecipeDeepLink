// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Swinject
import UIKit

/// Описание доступных методов создания модулей приложения
protocol Builder: AnyObject {
    /// Собирает таббар всея приложения
    func buildRecipelyTabBarController() -> RecipelyTabBarController
    /// Собирает экран авторизации пользователя
    func buildAuthScreen(coordinator: AuthCoordinatorProtocol) -> AuthView

    // Экраны секции рецептов
    /// Собирает экран со списком категорий блюд
    func buildCategoriesScreen(coordinator: RecipesCoordinatorProtocol) -> CategoriesView
    /// Собирает экран со списком блюд категории
    func buildCategoryDishesScreen(coordinator: RecipesCoordinatorProtocol, category: DishType)
        -> CategoryDishesView
    /// Собирает экран детальной информации по блюду
    func buildDishDetailsScreen(coordinator: RecipesCoordinatorProtocol, uri: String) -> DishDetailsView

    // Экраны секции любимых рецептов
    /// Собирает экран любимых рецептов
    func buildFavouritesScreen(coordinator: FavouritesCoordinatorProtocol) -> FavouritesView

    // Экраны секции профиля
    /// Собирает экран профиля пользователя
    func buildProfileScreen(coordinator: ProfileCoordinatorProtocol) -> ProfileView
    /// Собирает экран программы лояльности
    func buildLoyaltyProgramScreen(coordinator: ProfileCoordinatorProtocol) -> LoyaltyProgramView
    /// Собирает экран с картой и онформацией о партнерах
    func buildPartnersScreen(coordinator: ProfileCoordinatorProtocol) -> PartnersView
    /// Собирает экран с информацией о выбранной гоеточке на карте
    func buildLocationDetailScreen(
        coordinator: ProfileCoordinatorProtocol,
        locationInfo: MapLocation,
        completion: @escaping VoidHandler
    ) -> LocationDetailView
    /// Собирает экран правил использования
    func buildTermsOfUseScreen(coordinator: ProfileCoordinatorProtocol) -> TermsOfUseView
}

final class ModuleBuilder: Builder {
    // MARK: - Private Properties

    private var serviceContainer: Container

    // MARK: - Initializers

    init(serviceDistributor: Container) {
        serviceContainer = serviceDistributor
    }

    // MARK: - Public Methods

    func buildRecipelyTabBarController() -> RecipelyTabBarController {
        RecipelyTabBarController()
    }

    func buildAuthScreen(coordinator: AuthCoordinatorProtocol) -> AuthView {
        let view = AuthView()
        let presenter = AuthPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }

    // MARK: - Экраны секции рецептов

    func buildCategoriesScreen(coordinator: RecipesCoordinatorProtocol) -> CategoriesView {
        let view = CategoriesView()
        view.tabBarItem = UITabBarItem(
            title: Local.ModuleBuilder.recipesText,
            image: AssetImage.Icons.recipesIcon.image,
            selectedImage: AssetImage.Icons.recipesFilledIcon.image
        )
        let presenter = CategoriesPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }

    func buildCategoryDishesScreen(
        coordinator: RecipesCoordinatorProtocol,
        category: DishType
    ) -> CategoryDishesView {
        let view = CategoryDishesView()
        let presenter = CategoryDishesPresenter(
            view: view,
            coordinator: coordinator,
            networkService: serviceContainer.resolve(NetworkServiceProxy.self),
            imageLoadService: serviceContainer.resolve(ImageLoadProxy.self),
            category: category
        )
        view.presenter = presenter
        return view
    }

    func buildDishDetailsScreen(coordinator: RecipesCoordinatorProtocol, uri: String) -> DishDetailsView {
        let view = DishDetailsView()
        let presenter = DishDetailsPresenter(
            view: view,
            coordinator: coordinator,
            networkService: serviceContainer.resolve(NetworkServiceProxy.self),
            imageLoadService: serviceContainer.resolve(ImageLoadProxy.self),
            coreDataService: serviceContainer.resolve(CoreDataService.self),
            uri: uri
        )
        view.presenter = presenter
        return view
    }

    // MARK: - Экраны секции любимых рецептов

    func buildFavouritesScreen(coordinator: FavouritesCoordinatorProtocol) -> FavouritesView {
        let view = FavouritesView()
        view.tabBarItem = UITabBarItem(
            title: Local.ModuleBuilder.favouritesText,
            image: AssetImage.Icons.favouritesIcon.image,
            selectedImage: AssetImage.Icons.favouritesFilledIcon.image
        )
        let presenter = FavouritesPresenter(
            view: view,
            coordinator: coordinator,
            coreDataService: serviceContainer.resolve(CoreDataService.self),
            imageLoadService: serviceContainer.resolve(ImageLoadProxy.self)
        )
        view.presenter = presenter
        return view
    }

    // MARK: - Экраны секции профиля

    func buildProfileScreen(coordinator: ProfileCoordinatorProtocol) -> ProfileView {
        let view = ProfileView()
        view.tabBarItem = UITabBarItem(
            title: Local.ModuleBuilder.profileText,
            image: AssetImage.Icons.profileIcon.image,
            selectedImage: AssetImage.Icons.profileFilledIcon.image
        )
        let presenter = ProfilePresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }

    func buildLoyaltyProgramScreen(coordinator: ProfileCoordinatorProtocol) -> LoyaltyProgramView {
        let view = LoyaltyProgramView()
        let presenter = LoyaltyProgramPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        let sheet = view.sheetPresentationController
        sheet?.detents = [.custom { _ in 320 }]
        sheet?.prefersGrabberVisible = true
        sheet?.preferredCornerRadius = 30
        return view
    }

    func buildPartnersScreen(coordinator: ProfileCoordinatorProtocol) -> PartnersView {
        let view = PartnersView()
        let presenter = PartnersPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }

    func buildLocationDetailScreen(
        coordinator: ProfileCoordinatorProtocol,
        locationInfo: MapLocation,
        completion: @escaping VoidHandler
    ) -> LocationDetailView {
        let view = LocationDetailView()
        let presenter = LocationDetailPresenter(
            view: view,
            coordinator: coordinator,
            locationInfo: locationInfo,
            completion: completion
        )
        view.presenter = presenter
        let sheet = view.sheetPresentationController
        sheet?.detents = [.custom { _ in 250 }]
        sheet?.preferredCornerRadius = 30
        sheet?.prefersGrabberVisible = true
        return view
    }

    func buildTermsOfUseScreen(coordinator: ProfileCoordinatorProtocol) -> TermsOfUseView {
        let view = TermsOfUseView()
        let presenter = TermsOfUsePresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
