// ServiceDistributor.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол взаимодействия с ServiceDistributor
protocol ServiceDistributorProtocol: AnyObject {
    /// Региструрует переданный сервис
    func registerService<T: ServiceProtocol>(service: T)
    /// Выдает сервис указанного типа
    func getService<T: ServiceProtocol>(_ type: T.Type) -> T?
}

/// Обьект занимающийся управлением и выдачей сервисов
final class ServiceDistributor {
    private var servicesMap: [String: ServiceProtocol] = [:]
}

extension ServiceDistributor: ServiceDistributorProtocol {
    func registerService<T: ServiceProtocol>(service: T) {
        let key = String(describing: T.Type.self)
        servicesMap[key] = service
    }

    func getService<T: ServiceProtocol>(_ type: T.Type) -> T? {
        let key = String(describing: T.Type.self)
        return servicesMap[key] as? T
    }
}
