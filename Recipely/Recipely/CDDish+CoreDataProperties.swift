// CDDish+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// cccccc
public extension CDDish {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDDish> {
        NSFetchRequest<CDDish>(entityName: "CDDish")
    }

    @NSManaged var calories: Float
    @NSManaged var carbohydrates: Float
    @NSManaged var category: String?
    @NSManaged var cookingTime: Int16
    @NSManaged var fats: Float
    @NSManaged var isFavourite: Bool
    @NSManaged var linkToImage: String
    @NSManaged var linkToThumbnailImage: String
    @NSManaged var name: String
    @NSManaged var proteins: Float
    @NSManaged var recipe: String
    @NSManaged var uri: String
    @NSManaged var weight: Float
}
