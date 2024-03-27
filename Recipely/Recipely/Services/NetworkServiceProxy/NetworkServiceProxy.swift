// NetworkServiceProxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Проски для NetworkService занимающийся кешированием получаемых данных
final class NetworkServiceProxy {
    // MARK: - Public Properties

    var description: String {
        "DataStore service"
    }

    // MARK: - Private Properties

    private weak var networkService: NetworkServiceProtocol?
    private weak var coreDataService: CoreDataServiceProtocol?

    // MARK: - Initializers

    init(networkService: NetworkServiceProtocol, coreDataService: CoreDataServiceProtocol) {
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
}

extension NetworkServiceProxy: NetworkServiceProtocol {
    func searchForDishes(
        dishType: DishType,
        health: String?,
        query: String?,
        completion: @escaping (Result<[Dish], Error>) -> Void
    ) {
        var compasedQuery: String?
        switch dishType {
        case .chicken, .meat, .fish:
            compasedQuery = dishType.rawValue
            if query != nil {
                compasedQuery?.append(" ")
            }
        default:
            break
        }

        if let query {
            if compasedQuery != nil {
                compasedQuery?.append(query)
            } else {
                compasedQuery = query
            }
        }

        networkService?.searchForDishes(dishType: dishType, health: health, query: compasedQuery) { result in
            switch result {
            case let .success(dishes):
                completion(.success(dishes))
                self.coreDataService?.saveDishes(dishes)
            case let .failure(error):
                self.coreDataService?.fetchDishes(ofCategory: dishType, query: query) { dishes in
                    switch dishes {
                    case let .some(dishes):
                        completion(.success(dishes))
                    case .none:
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    func getDish(byURI uri: String, completion: @escaping (Result<Dish, Error>) -> Void) {
        networkService?.getDish(byURI: uri) { result in
            switch result {
            case let .success(dish):
                completion(.success(dish))
                self.coreDataService?.saveDishes([dish])
            case let .failure(error):
                self.coreDataService?.fetchDish(byURI: uri) { dish in
                    switch dish {
                    case let .some(dish):
                        completion(.success(dish))
                    case .none:
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
