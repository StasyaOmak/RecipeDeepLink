// ViewState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояние данных.
enum ViewState {
    /// Состояние, когда данные успешно загружены и содержат объект типа CategoryDish.
    case data(CategoryDish)
    /// Состояние, когда данных нет или загрузка завершилась неудачно.
    case loading
}
