// CaseIterable+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для типов, соответствующих протоколу `CaseIterable` и `Comparable`.
extension CaseIterable where Self: Comparable {
    /// Возвращает следующий случай перечисления в порядке объявления.
    var next: Self {
        guard let currentIndex = Self.allCases.firstIndex(where: { $0 == self }) as? Int,
              let nextIndex = ((currentIndex + 1) % Self.allCases.count) as? Self.AllCases.Index
        else { return self }
        return Self.allCases[nextIndex]
    }
}
