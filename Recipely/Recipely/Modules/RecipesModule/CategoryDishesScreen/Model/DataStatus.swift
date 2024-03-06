// DataStatus.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Проверка данных
enum DataStatus {
    /// Данные загрузились
    case dataLoaded(CategoryDish)
    /// Данные не загрузились
    case noData
}
