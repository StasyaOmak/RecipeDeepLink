// CoreDataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

protocol CoreDataServiceProtocol: AnyObject, ServiceProtocol {
    func saveDishes(_ dishes: [Dish])
    func fetchDishes(ofCategory dishCategory: DishType, query: String?, _ completion: @escaping ([Dish]?) -> ())
    func fetchDish(byURI uri: String, _ completion: @escaping (Dish?) -> ())
}

final class CoreDataService {
    // MARK: - Private Properties

    private lazy var container = {
        let container = NSPersistentContainer(name: "CoreDataDish")

        container.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return container
    }()

    private var context: NSManagedObjectContext {
        container.viewContext
    }

    private lazy var privateContext = {
        let context = NSManagedObjectContext(.privateQueue)
        context.parent = self.context
        return context
    }()

    var description: String {
        "CoreData service"
    }

    // MARK: - Private Methods

    private func isDishAlreadyExists(dish: Dish) -> Bool {
        let request = CDDish.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", dish.uri)
        do {
            let count = try privateContext.count(for: request)
            return count > 0
        } catch {}
        return true
    }
}

extension CoreDataService: CoreDataServiceProtocol {
    func saveDishes(_ dishes: [Dish]) {
        privateContext.perform {
            for item in dishes {
                guard !self.isDishAlreadyExists(dish: item) else {
                    continue
                }
                self.privateContext.insert(CDDish(dish: item, context: self.privateContext))
            }
            do {
                try self.privateContext.save()
                try self.context.performAndWait {
                    try self.context.save()
                }
            } catch {}
        }
    }

    func fetchDishes(ofCategory dishCategory: DishType, query: String?, _ completion: @escaping ([Dish]?) -> ()) {
        privateContext.perform {
            let request = CDDish.fetchRequest()
            request.predicate =
                if let query {
                    NSPredicate(
                        format: "category ==[c] %@ AND name contains[c] %@",
                        argumentArray: [dishCategory.rawValue, query]
                    )
                } else {
                    NSPredicate(format: "category ==[c] %@", dishCategory.rawValue)
                }
            do {
                let results = try self.privateContext.fetch(request)
                let dishes = results.map { Dish(cdDish: $0) }
                completion(dishes)
            } catch {
                completion(nil)
            }
        }
    }

    func fetchDish(byURI uri: String, _ completion: @escaping (Dish?) -> ()) {
        privateContext.perform {
            let request = CDDish.fetchRequest()
            request.predicate = NSPredicate(format: "uri LIKE %@", uri)
            do {
                let results = try self.privateContext.fetch(request)
                if let dish = results.first {
                    completion(Dish(cdDish: dish))
                }
            } catch {
                completion(nil)
            }
        }
    }
}
