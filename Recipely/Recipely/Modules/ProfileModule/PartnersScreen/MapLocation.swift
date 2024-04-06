// MapLocation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import GoogleMaps

/// Точка на карте
struct MapLocation: Codable {
    /// Широта точки
    var latitude: Double
    /// Долгота точки
    var longitude: Double
    /// Партнер
    var partner: Partner
    /// Адрес локации
    var address: String?
}

extension MapLocation: Equatable {
    static func == (lhs: MapLocation, rhs: MapLocation) -> Bool {
        lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}
