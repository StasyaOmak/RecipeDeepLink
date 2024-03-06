// SortState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояния контрола
enum SortState: Int, CaseIterable, Comparable {
    /// Не сортируется
    case none
    /// Сортировка от меньшего к большему
    case accending
    /// Сортировка от большего к меньшему
    case deccending

    static func < (lhs: SortState, rhs: SortState) -> Bool {
        lhs.rawValue > rhs.rawValue
    }
}
