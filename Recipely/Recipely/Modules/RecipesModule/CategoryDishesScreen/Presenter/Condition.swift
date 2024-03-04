// Condition.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояния контрола
enum Condition: Int, CaseIterable {
    /// не нажат
    case notPressed
    /// нажат сортировка от меньшего к большему
    case sortingMore
    /// нажат сортировка от большего к меньшему
    case sortingSmaller

    var next: Condition {
        Condition(rawValue: (rawValue + 1) % (Condition.allCases.count)) ?? .notPressed
    }
}
