// CDDish+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

extension CDDish {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDDish> {
        NSFetchRequest<CDDish>(entityName: "CDDish")
    }

    /// Энергетическая ценность блюда.
    @NSManaged var calories: Float
    /// Количество углеводов в блюде.
    @NSManaged var carbohydrates: Float
    /// Тип блюда
    @NSManaged var category: String?
    /// Время приготовления блюда в минутах.
    @NSManaged var cookingTime: Int16
    /// Количество жиров в блюде.
    @NSManaged var fats: Float
    /// Является ли рецепт любимым
    @NSManaged var isFavourite: Bool
    /// Сылка на изображение блюда
    @NSManaged var linkToImage: String
    /// Сылка на изображение блюда в сжатом формате
    @NSManaged var linkToThumbnailImage: String
    /// Название блюда
    @NSManaged var name: String
    /// Количество белков в блюде.
    @NSManaged var proteins: Float
    /// Рецепт блюда.
    @NSManaged var recipe: String
    /// Идентификатор блюда
    @NSManaged var uri: String
    /// Вес блюда
    @NSManaged var weight: Float
}
