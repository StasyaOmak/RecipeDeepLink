// ResponceDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура для декодирования JSON-ответа от сервера.
struct ResponseDTO: Codable {
    /// Массив объектов типа `HitDTO`, содержащих информацию о рецептах.
    let hits: [HitDTO]
}
