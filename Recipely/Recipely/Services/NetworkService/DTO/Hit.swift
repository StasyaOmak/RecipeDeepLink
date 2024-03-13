//
//  Hit.swift
//  Recipely
//
//  Created by Tixon Markin on 13.03.2024.
//

import Foundation

/// Структура, представляющая отдельный элемент массива `hits` в JSON-ответе.
struct Hit: Codable {
    /// Объект типа `DishDTO`, содержащий информацию о конкретном блюде.
    let recipe: DishDTO
}
