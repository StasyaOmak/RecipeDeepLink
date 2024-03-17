// NetworkServiceProxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class NetworkServiceProxy {
    private let networkService: NetworkServiceProtocol
    private let coreDataService: CoreDataServiceProtocol

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
        var predicate: String?
        switch dishType {
        case .chicken, .meat, .fish:
            predicate = dishType.rawValue
            if query != nil {
                predicate?.append(" ")
            }
        default:
            break
        }

        if let query {
            if predicate != nil {
                predicate?.append(query)
            } else {
                predicate = query
            }
        }

        networkService.searchForDishes(dishType: dishType, health: health, query: predicate) { result in
            switch result {
            case let .success(dishes):
                completion(.success(dishes))
                self.coreDataService.saveDishes(dishes)
            case let .failure(error):
                self.coreDataService.fetchDishes(ofCategory: dishType, query: query) { dishes in
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
        networkService.getDish(byURI: uri) { result in
            switch result {
            case let .success(dish):
                completion(.success(dish))
                self.coreDataService.saveDishes([dish])
            case let .failure(error):
                self.coreDataService.fetchDish(byURI: uri) { dish in
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

    var description: String {
        "DataStore service"
    }
}
