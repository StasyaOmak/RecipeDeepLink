// CDDish+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Модель блюда для CoreData
public extension CDDish {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDDish> {
        NSFetchRequest<CDDish>(entityName: "CDDish")
    }

    @NSManaged var uri: String?
    @NSManaged var linkToImage: String?
    @NSManaged var linkToThumbnailImage: String?
    @NSManaged var name: String?
    @NSManaged var weight: Float
    @NSManaged var cookingTime: Int64
    @NSManaged var calories: Float
    @NSManaged var carbohydrates: Float
    @NSManaged var fats: Float
    @NSManaged var proteins: Float
    @NSManaged var recipe: String?
}
