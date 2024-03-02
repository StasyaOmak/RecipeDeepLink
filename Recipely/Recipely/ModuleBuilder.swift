// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Описание доступных методов создания модулей приложения
protocol Builder: AnyObject {
    /// Собирает таббар всея приложения
    func buildRecipelyTabBarController() -> RecipelyTabBarController
    /// Собирает экран авторизации пользователя
    func buildAuthScreen(coordinator: AuthCoordinatorProtocol) -> AuthView
    /// Собирает экран со списком рецептов
    func buildRecipesCategoriesScreen(coordinator: RecipesCoordinatorProtocol) -> RecipesCategoriesView
    /// Собирает экран любимых рецептов
    func buildFavouritesScreen(coordinator: FavouritesCoordinatorProtocol) -> FavouritesView
    /// Собирает экран рецепта
    func buildRecipeDetailScreen(coordinator: RecipesCoordinatorProtocol) -> RecipeDetailView
    /// Собирает экран профиля пользователя
    func buildProfileScreen(coordinator: ProfileCoordinatorProtocol) -> ProfileView
    /// Собирает экран программы лояльности
    func buildLoyaltyProgramScreen(coordinator: ProfileCoordinatorProtocol) -> LoyaltyProgramView
    /// Собирает экран со списком категорий рецептов
    func buildCategoryScreen(coordinator: RecipesCoordinatorProtocol, title: String) -> CategoryView
}

final class ModuleBuilder: Builder {
    // MARK: - Constants

    private enum Constants {
        static let recipesText = "Recipes"
        static let favouritesText = "Favourites"
        static let profileText = "Profile"
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

    func buildRecipesCategoriesScreen(coordinator: RecipesCoordinatorProtocol) -> RecipesCategoriesView {
        let view = RecipesCategoriesView()
        view.tabBarItem = UITabBarItem(
            title: Constants.recipesText,
            image: .recipesIcon,
            selectedImage: .recipesFilledIcon
        )
        let presenter = RecipesCategoriesPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }

    func buildCategoryScreen(coordinator: RecipesCoordinatorProtocol, title: String) -> CategoryView {
        let view = CategoryView()
        let presenter = CategoryPresenter(view: view, coordinator: coordinator, viewTitle: title)
        view.presenter = presenter
        return view
    }

    func buildRecipeDetailScreen(coordinator: RecipesCoordinatorProtocol) -> RecipeDetailView {
        let view = RecipeDetailView()
        let presenter = RecipeDetailPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }

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
}
