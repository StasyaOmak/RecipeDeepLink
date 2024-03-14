// ServiceDistributor.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ServiceDistributorProtocol: AnyObject {
    func registerService<T: ServiceProtocol>(service: T)
    func getService<T: ServiceProtocol>(_ type: T.Type) -> T?
}

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
