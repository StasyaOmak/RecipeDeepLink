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
        } catch {
            print(error.localizedDescription)
        }
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
                    print("saved to cre data")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func fetchDishes(ofCategory dishCategory: DishType, query: String?, _ completion: @escaping ([Dish]?) -> ()) {
        privateContext.perform {
            let request = CDDish.fetchRequest()
            request.predicate = NSPredicate(
                format: "category == %@ AND name LIKE %@",
                argumentArray: [dishCategory.stringValue, query ?? ""]
            )
            do {
                let results = try self.privateContext.fetch(request)
                let dishes = results.map { Dish(cdDish: $0) }
                print("fetched from core data")
                completion(dishes)
            } catch {
                print(error.localizedDescription)
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
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
