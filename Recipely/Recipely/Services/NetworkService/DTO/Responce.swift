//
//  Responce.swift
//  Recipely
//
//  Created by Tixon Markin on 13.03.2024.
//

import Foundation

/// Структура для декодирования JSON-ответа от сервера.
struct Response: Codable {
    /// Массив объектов типа `Hit`, содержащих информацию о блюдах.
    let hits: [Hit]
}
