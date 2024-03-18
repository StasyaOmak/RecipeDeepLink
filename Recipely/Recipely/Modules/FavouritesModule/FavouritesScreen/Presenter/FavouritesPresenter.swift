// FavouritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с FavouritesPresenter
protocol FavouritesPresenterProtocol: AnyObject {
    var dishes: [Dish] { get }
    /// Сообщает о появлении контроллера на экране
    func viewWillAppear()
    /// удаляет рецепт из избранного.
    func removeItem(atIndex index: Int)
    /// Получить данные изображения для ячейки по индексу
    func getImageForCell(atIndex index: Int, completion: @escaping (Data, Int) -> ())
}

/// Презентер экрана списка сохраненных рецептов
final class FavouritesPresenter {
    // MARK: - Private Properties

    private weak var coordinator: FavouritesCoordinatorProtocol?
    private weak var view: FavouritesViewProtocol?
    private weak var coreDataService: CoreDataServiceProtocol?
    private weak var imageLoadService: ImageLoadServiceProtocol?

    private(set) var dishes: [Dish] = [] {
        didSet {
            view?.setPlaceholderViewIsHidden(to: !dishes.isEmpty)
        }
    }

    // MARK: - Initializers

    init(
        view: FavouritesView,
        coordinator: FavouritesCoordinatorProtocol,
        coreDataService: CoreDataServiceProtocol?,
        imageLoadService: ImageLoadServiceProtocol?
    ) {
        self.view = view
        self.coordinator = coordinator
        self.coreDataService = coreDataService
        self.imageLoadService = imageLoadService
        addDishListener()
    }

    // MARK: - Life Cycle

    deinit {
        coreDataService?.removeListener(for: self)
    }

    // MARK: - Private Methods

    private func addDishListener() {
        coreDataService?.addDishListener(for: self) { [weak self] updatedDish in
            if updatedDish.isFavourite {
                self?.dishes.append(updatedDish)
                DispatchQueue.main.async {
                    self?.view?.tableViewAppendRow()
                }
            } else {
                guard let removalIndex = self?.dishes
                    .firstIndex(where: { $0.uri == updatedDish.uri })
                else { return }
                self?.dishes.remove(at: removalIndex)
                DispatchQueue.main.async {
                    self?.view?.tableViewDeleteRow(atIndex: removalIndex)
                }
            }
        }
    }
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    func viewWillAppear() {
        coreDataService?.getFavouriteDishes { dishes in
            self.dishes = dishes
            DispatchQueue.main.async {
                self.view?.setPlaceholderViewIsHidden(to: !dishes.isEmpty)
                self.view?.reloadTable()
            }
        }
    }

    func removeItem(atIndex index: Int) {
        var removedDish = dishes.remove(at: index)
        removedDish.isFavourite = false
        coreDataService?.updateIsFavouriteStatus(forDish: removedDish)
    }

    func getImageForCell(atIndex index: Int, completion: @escaping (Data, Int) -> ()) {
        guard let url = URL(string: dishes[index].linkToThumbnailImage) else { return }
        imageLoadService?.loadImage(atURL: url) { data, _, _ in
            if let data {
                completion(data, index)
            }
        }
    }
}
