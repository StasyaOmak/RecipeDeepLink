// FavouritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с FavouritesPresenter
protocol FavouritesPresenterProtocol: AnyObject {
    /// Сообщает о появлении контроллера на экране
    func viewWillAppear()
    /// Возвращает количество подразделов рецептов
    func getNumberOfDishes() -> Int
    /// Возвращает массив секций рецептов для отображения в пользовательском интерфейсе.
    func getDish(forIndex index: Int) -> Dish
    /// удаляет рецепт из избранного.
    func removeItem(atIndex index: Int)
}

/// Презентер экрана списка сохраненных рецептов
final class FavouritesPresenter {
    // MARK: - Private Properties

    private weak var coordinator: FavouritesCoordinatorProtocol?
    private weak var view: FavouritesViewProtocol?
    private var favouriteDishes = DishesService.shared.getFavouriteDishes() {
        didSet {
            view?.setPlaceholderViewIsHidden(to: !favouriteDishes.isEmpty)
        }
    }

    // MARK: - Initializers

    init(view: FavouritesView, coordinator: FavouritesCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
        addDishListener()
    }

    // MARK: - Life Cycle

    deinit {
        print("deinit ", String(describing: self))
        DishesService.shared.removeListener(for: self)
    }

    // MARK: - Private Methods

    private func addDishListener() {
        DishesService.shared.addDishListener(for: self) { [weak self] updatedDish in
            if updatedDish.isFavourite {
                self?.favouriteDishes.append(updatedDish)
                self?.view?.tableViewAppendRow()
            } else {
                guard let removalIndex = self?.favouriteDishes
                    .firstIndex(where: { $0 == updatedDish })
                else { return }
                self?.favouriteDishes.remove(at: removalIndex)
                self?.view?.tableViewDeleteRow(atIndex: removalIndex)
            }
        }
    }
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    func viewWillAppear() {
        view?.setPlaceholderViewIsHidden(to: !favouriteDishes.isEmpty)
    }

    func getNumberOfDishes() -> Int {
        favouriteDishes.count
    }

    func getDish(forIndex index: Int) -> Dish {
        favouriteDishes[index]
    }

    func removeItem(atIndex index: Int) {
        let removedDish = favouriteDishes.remove(at: index)
        DishesService.shared.removeFromFavourites(dish: removedDish)
    }
}
