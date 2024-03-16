// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

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
    /// Собирает экран правил использования
    func buildTermsOfUseScreen(coordinator: ProfileCoordinatorProtocol) -> TermsOfUseView
}

final class ModuleBuilder: Builder {
    // MARK: - Constants

    private enum Constants {
        static let recipesText = "Recipes"
        static let favouritesText = "Favourites"
        static let profileText = "Profile"
    }

    // MARK: - Private Properties

    private var serviceDistributor: ServiceDistributorProtocol

    // MARK: - Initializers

    init(serviceDistributor: ServiceDistributorProtocol) {
        self.serviceDistributor = serviceDistributor
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
            title: Constants.recipesText,
            image: .recipesIcon,
            selectedImage: .recipesFilledIcon
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
            networkService: serviceDistributor.getService(NetworkServiceProxy.self),
            imageLoadService: serviceDistributor.getService(ImageLoadProxy.self),
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
            networkService: serviceDistributor.getService(NetworkServiceProxy.self),
            imageLoadService: serviceDistributor.getService(ImageLoadProxy.self),
            uri: uri
        )

        view.presenter = presenter
        return view
    }

    // MARK: - Экраны секции любимых рецептов

    func buildFavouritesScreen(coordinator: FavouritesCoordinatorProtocol) -> FavouritesView {
        let view = FavouritesView()
        view.tabBarItem = UITabBarItem(
            title: Constants.favouritesText,
            image: .favouritesIcon,
            selectedImage: .favouritesFilledIcon
        )
        let presenter = FavouritesPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }

    // MARK: - Экраны секции профиля

    func buildProfileScreen(coordinator: ProfileCoordinatorProtocol) -> ProfileView {
        let view = ProfileView()
        view.tabBarItem = UITabBarItem(
            title: Constants.profileText,
            image: .profileIcon,
            selectedImage: .profileFilledIcon
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
        sheet?.detents = [.custom(resolver: { _ in 320 })]
        sheet?.prefersGrabberVisible = true
        sheet?.preferredCornerRadius = 30
        return view
    }

    func buildTermsOfUseScreen(coordinator: ProfileCoordinatorProtocol) -> TermsOfUseView {
        let view = TermsOfUseView()
        let presenter = TermsOfUsePresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
