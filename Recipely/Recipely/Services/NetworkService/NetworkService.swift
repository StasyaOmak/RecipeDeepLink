// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол коммуникации с NetworkService
protocol NetworkServiceProtocol: AnyObject {
    /// Запрашивает массив блюд с переданными параметрами запроса
    func searchForDishes(
        dishType: DishCategory,
        health: String?,
        query: String?,
        completion: @escaping (Result<[Dish], Error>) -> Void
    )
    /// Запрашивает конкретный блюдо по URI
    func getDish(
        byURI uri: String,
        completion: @escaping (Result<Dish, Error>) -> Void
    )
}

/// Сервис для работы с Recipe Search API
final class NetworkService {
    // MARK: - Constants

    enum Constants {
        static let appKey = "432a035bdb4cc9008e4fbb1fe17990bb"
        static let appId = "9b070203"
        static let type = "public"
        static let dishTypeKey = "dishType"
        static let queryKey = "q"
        static let healthKey = "health"
        static let uriKey = "uri"
    }

    // MARK: - Private Properties

    private let baseUrlComponents = {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.edamam.com"
        component.path = "/api/recipes/v2"
        component.queryItems = [
            .init(name: "app_id", value: Constants.appId),
            .init(name: "app_key", value: Constants.appKey),
            .init(name: "type", value: Constants.type)
        ]
        return component
    }()

    // MARK: - Private Methods

    private func makeURLRequest<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

extension NetworkService: ServiceProtocol {
    var description: String {
        "Network service"
    }
}

extension NetworkService: NetworkServiceProtocol {
    func searchForDishes(
        dishType: DishCategory,
        health: String?,
        query: String?,
        completion: @escaping (Result<[Dish], Error>) -> Void
    ) {
        var baseUrlComponents = baseUrlComponents
        baseUrlComponents.queryItems?.append(.init(name: Constants.dishTypeKey, value: dishType.stringValue))
        if let query {
            baseUrlComponents.queryItems?.append(.init(name: Constants.queryKey, value: query))
        }
        if let health {
            baseUrlComponents.queryItems?.append(.init(name: Constants.healthKey, value: health))
        }

        guard let url = baseUrlComponents.url else { return }
        makeURLRequest(URLRequest(url: url)) { (result: Result<ResponseDTO, Error>) in
            switch result {
            case let .success(responce):
                let dishes = responce.hits.map { Dish(dto: $0.recipe) }
                completion(.success(dishes))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getDish(byURI uri: String, completion: @escaping (Result<Dish, Error>) -> Void) {
        var baseUrlComponents = baseUrlComponents
        baseUrlComponents.queryItems?.append(.init(name: Constants.uriKey, value: uri))
        guard var url = baseUrlComponents.url else { return }
        url.append(path: "by-uri")

        makeURLRequest(URLRequest(url: url)) { (result: Result<ResponseDTO, Error>) in
            switch result {
            case let .success(responce):
                guard let dishDto = responce.hits.first?.recipe else { return }
                completion(.success(Dish(dto: dishDto)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
