// URL+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для удобного добавления расширения файла
extension URL {
    // MARK: - Types

    /// Тип расширения файла
    enum PathExtension: String {
        /// Расширение txt
        case txt
        /// Расширение pdf
        case pdf
        /// Расширение png
        case png
        /// Расширение jpg
        case jpg
    }

    // MARK: - Public Methods

    /// Добавляет указанное расширение к существующему URL
    /// - Parameter pathExtension: Расширение которое нужно добавить
    /// - Returns: `URL` URL c добавленным расширением
    func appendingPathExtension(_ pathExtension: PathExtension) -> URL {
        appendingPathExtension(pathExtension.rawValue)
    }
}

extension URL {
    /// Имя файла мока
    enum MockFileName: String {
        /// Посты
        case posts = "mockDishes"
        /// Пустой ответ
        case empty
    }

    static func makeURL(_ urlString: String, mockFileName: MockFileName) -> URL? {
        var newURL = URL(string: urlString)
        guard Constants.isMockMode else { return newURL }
        let fileName = mockFileName.rawValue
        let bundleURL = Bundle.main.url(forResource: fileName, withExtension: "json")
        guard let bundleURL = bundleURL else {
            let errorText = "Отсутствует моковый файл: \(fileName).json"
            debugPrint(errorText)
            return nil
        }
        newURL = bundleURL
        return newURL
    }
}
