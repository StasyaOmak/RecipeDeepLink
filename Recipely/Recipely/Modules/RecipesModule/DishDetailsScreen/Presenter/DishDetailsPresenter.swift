// DishDetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс взаимодействия с DishDetailsPresenter
protocol DishDetailsPresenterProtocol {
    /// Состояние загрузки
    var state: ViewState<Dish> { get }
    /// Сообщает о том, что вью начала свой жизненный цикл
    func viewBeganLoading()
    /// Сообщает о назатии на кнопку поделиться
    func shareButtonTapped()
    /// Сообщает онажатии на кнопку добавления в любимые блюда
    func addToFavouritesButtonTapped()
    /// Сообщает что вью загрузилась
    func viewLoaded()
    /// Получить данные изображения для ячейки по индексу
    func getImageForCell(atIndex index: Int, completion: @escaping (Data, Int) -> ())
}

/// Презентер экрана детального описания блюда
final class DishDetailsPresenter {
    // MARK: - Constants

    private enum Constants {
        static let userSharedRecipeLogMessage = "Пользователь поделился рецептом "
    }

    private weak var imageLoadService: ImageLoadServiceProtocol?
    private weak var view: DishDetailsViewProtocol?
    private var uri: String
    private weak var coordinator: RecipesCoordinatorProtocol?
    private let networkService = NetworkService()
//    private var dish: Dish {
//        didSet {
    ////            view?.updateFavouritesButtonState(to: dish.isFavourite)
//        }
//    }

    var state: ViewState<Dish> = .loading {
        didSet {
            view?.updateState()
        }
    }

    // MARK: - Initializers

    init(view: DishDetailsViewProtocol, coordinator: RecipesCoordinatorProtocol, uri: String) {
        self.view = view
        self.coordinator = coordinator
        self.uri = uri
    }

    // MARK: - Life Cycle

    deinit {
//        DishesService.shared.removeListener(for: self)
    }

    // MARK: - Private Methods

//    private func addDishListener() {
//        DishesService.shared.addDishListener(for: self) { [weak self] updatedDish in
//            self?.dish = updatedDish
//        }
//    }

    private func updateRecipe() {
        state = .loading
        networkService.getDish(byURI: uri) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(recipe):
                    self?.state = .data(recipe)
                    self?.view?.errorView(state: .data(Any.self))
                case let .failure(error):
                    self?.state = .error(error)
                    self?.view?.errorView(state: .error(error))
                }
            }
        }
    }
}

extension DishDetailsPresenter: DishDetailsPresenterProtocol {
    func getImageForCell(atIndex index: Int, completion: @escaping (Data, Int) -> ()) {
        guard case let .data(dishes) = state,
              let url = URL(string: dishes.image)
        else { return }
        imageLoadService?.loadImage(atURL: url) { data, _, _ in
            if let data {
                completion(data, index)
            }
        }
    }

    func viewLoaded() {
        updateRecipe()
    }

    func viewBeganLoading() {
//        view?.configure(with: dish)
    }

    func shareButtonTapped() {
//        LogAction.log(Constants.userSharedRecipeLogMessage + dish.name)
    }

    func addToFavouritesButtonTapped() {}
}
