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
    func serchForDishes(dishType: String,
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
    }
    
    // MARK: - Private Properties
    private let baseUrlComponents = {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.edamam.com"
        component.path = "/api/recipes/v2"
        let queryItemQuery = URLQueryItem(name: "app_id", value: Constants.appId)
        let queryItemQuery1 = URLQueryItem(name: "app_key", value: Constants.appKey)
        let queryItemQuery2 = URLQueryItem(name: "type", value: Constants.type)
        component.queryItems = [queryItemQuery, queryItemQuery1, queryItemQuery2]
        return component
    }()
    
    // MARK: - Private Methods
    
    private func makeURLRequest<SomeType: Codable>(using request: URL, completion: @escaping (Result<SomeType, Error>) -> Void) {
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
                print(error)
            }
        }.resume()
    }
}

extension NetworkService: NetworkerviceProtocol {
    func serchForDishes(dishType: String, health: String?, query: String?, completion: @escaping (Result<[Dish], Error>) -> Void) {
        var baseUrlComponents = baseUrlComponents
        let dishTypeItem = URLQueryItem(name: "dishType", value: dishType)
        baseUrlComponents.queryItems?.append(dishTypeItem)
        
        if let query {
            let queryItem = URLQueryItem(name: "q", value: query)
            baseUrlComponents.queryItems?.append(queryItem)
        }
        if let health {
            let healthItem = URLQueryItem(name: "health", value: health)
            baseUrlComponents.queryItems?.append(healthItem)
        }
        guard let url = baseUrlComponents.url  else { return }
        
        makeURLRequest(using: url) { (networkResult: Result<Response, Error>) in
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
        let uriItem = URLQueryItem(name: "uri", value: uri)
        baseUrlComponents.queryItems?.append(uriItem)
        guard var url = baseUrlComponents.url else { return }
        url.append(path: "by-uri")
        
        makeURLRequest(using: url) { (networkResult: Result<Response, Error>) in
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
