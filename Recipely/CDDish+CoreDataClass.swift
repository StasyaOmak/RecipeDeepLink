// CDDish+CoreDataClass.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

@objc(CDDish)
public class CDDish: NSManagedObject {
    convenience init(dish: Dish, context: NSManagedObjectContext) {
        self.init(context: context)
        uri = dish.uri
        linkToImage = dish.linkToImage
        linkToThumbnailImage = dish.linkToThumbnailImage
        name = dish.name
        weight = dish.weight
        category = dish.category
        cookingTime = Int16(dish.cookingTime)
        calories = dish.calories
        carbohydrates = dish.carbohydrates
        fats = dish.fats
        proteins = dish.proteins
        recipe = dish.recipe
        isFavourite = dish.isFavourite
    }
}
