//
//  NetworkService.swift
//  Recipely
//
//  Created by Tixon Markin on 13.03.2024.
//

import Foundation

/// Протокол коммуникации с NetworkService
protocol NetworkerviceProtocol {
    /// Запрос масива блюд по переденным параметрам
    func searchForDishes(dishType: DishType,
                        health: String?,
                        query: String?,
                        completion: @escaping (Result<[Dish], Error>) -> Void)
    /// Запрос блюда по его uri
    func getDish(byURI uri: String,
                 completion: @escaping (Result<Dish, Error>) -> Void)
}

class NetworkService {
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
    
    private func makeURLRequest<SomeType: Codable>(_ request: URLRequest, completion: @escaping (Result<SomeType, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data else { return }
            do {
                let result = try JSONDecoder().decode(SomeType.self, from: data)
                completion(.success(result))
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}

extension NetworkService: NetworkerviceProtocol {
    func searchForDishes(dishType: DishType, health: String?, query: String?, completion: @escaping (Result<[Dish], Error>) -> Void) {
        var baseUrlComponents = baseUrlComponents
        baseUrlComponents.queryItems?.append(.init(name: Constants.dishTypeKey, value: dishType.stringValue))
        
        if let query {
            baseUrlComponents.queryItems?.append(.init(name: Constants.queryKey, value: query))
        }
        if let health {
            baseUrlComponents.queryItems?.append(.init(name: Constants.healthKey, value: health))
        }
        
        guard let url = baseUrlComponents.url else { return }
        makeURLRequest(URLRequest(url: url)) { (networkResult: Result<Response, Error>) in
            switch networkResult {
            case .success(let result):
                let dishes = result.hits.map { Dish(dto: $0.recipe) }
                completion(.success(dishes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDish(byURI uri: String, completion: @escaping (Result<Dish, Error>) -> Void) {
        var baseUrlComponents = baseUrlComponents
        baseUrlComponents.queryItems?.append(.init(name: Constants.uriKey, value: uri))
        guard var url = baseUrlComponents.url else { return }
        url.append(path: "by-uri")
        
        makeURLRequest(URLRequest(url: url)) { (networkResult: Result<Response, Error>) in
            switch networkResult {
            case .success(let result):
                guard let dishDto = result.hits.first?.recipe else { return }
                completion(.success(Dish(dto: dishDto)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
