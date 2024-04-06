// Partner.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация по обхекту на карте
struct Partner: Codable {
    /// Наименование объекта
    var name: String
    /// Скидка партнера
    var discount = 30
    /// Промокод партнера
    var promocode = "RECIPE30"
}
