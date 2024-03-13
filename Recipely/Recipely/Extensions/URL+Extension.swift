// URL+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для удобного добавления расширения файла
extension URL {
    // MARK: - Types

    /// Тип расширения файла
    enum PathExtension: String {
        /// Текстовый файл
        case txt
        /// Файл PDF
        case pdf
        /// Файл PNG
        case png
    }

    // MARK: - Public Methods

    /// Добавляет указанное расширение к существующему URL
    /// - Parameter pathExtension: Расширение которое нужно добавить
    /// - Returns: `URL` URL c добавленным расширением
    func appendingPathExtension(_ pathExtension: PathExtension) -> URL {
        appendingPathExtension(pathExtension.rawValue)
    }
}
