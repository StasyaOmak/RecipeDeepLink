// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Описание доступных методов создания модулей приложения
protocol Builder: AnyObject {
    /// Собирает таббар всея приложения
    func buildRecipelyTabBarController() -> RecipelyTabBarController
    /// Собирает экран авторизации пользователя
    func buildAuthScreen() -> AuthView
    /// Собирает экран профиля пользователя
    func buildProfileScreen() -> ProfileView
    /// Собирает экран со списком рецептов
    func buildRecipesScreen() -> RecipesView
    /// Собирает экран любимых рецептов
    func buildFavouritesScreen() -> FavouritesView
}

final class ModuleBuilder: Builder {
    // MARK: - Public Methods

    func buildRecipelyTabBarController() -> RecipelyTabBarController {
        RecipelyTabBarController()
    }

    func buildAuthScreen() -> AuthView {
        let view = AuthView()
        let presenter = AuthPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }

    func buildProfileScreen() -> ProfileView {
        let view = ProfileView()
        view.tabBarItem = UITabBarItem(
            title: "Profile",
            image: .profileIcon,
            selectedImage: .profileFilledIcon
        )
        let presenter = ProfilePresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }

    func buildFavouritesScreen() -> FavouritesView {
        let view = FavouritesView()
        view.tabBarItem = UITabBarItem(
            title: "Favourites",
            image: .favouritesIcon,
            selectedImage: .favouritesFilledIcon
        )
        let presenter = FavouritesPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }

    func buildRecipesScreen() -> RecipesView {
        let view = RecipesView()
        view.tabBarItem = UITabBarItem(title: "Recipes", image: .recipesIcon, selectedImage: .recipesFilledIcon)
        let presenter = RecipesPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
