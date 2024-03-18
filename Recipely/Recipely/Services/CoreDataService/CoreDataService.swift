// CoreDataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Протокол взаимодействия с сервисом Core Data.
protocol CoreDataServiceProtocol: AnyObject, ServiceProtocol {
    /// Сохраняет переданные блюда в базу данных.
    func saveDishes(_ dishes: [Dish])
    /// Выполняет поиск блюд по категории и переданному запросу и возвращает результат в замыкании.
    func fetchDishes(ofCategory dishCategory: DishType, query: String?, _ completion: @escaping ([Dish]?) -> ())
    /// Выполняет поиск блюда по URI и возвращает результат в замыкании.
    func fetchDish(byURI uri: String, _ completion: @escaping (Dish?) -> ())
    /// Возвращает в замыкании все блюда, у которых `isFavourite == true`.
    func getFavouriteDishes(_ completion: @escaping ([Dish]) -> ())
    /// Обновляет значение `isFavourite` для переданного блюда в базе данных.
    func updateIsFavouriteStatus(forDish dish: Dish)
    /// Проверяет, является ли переданное блюдо избранным.
    func isDishFavourite(_ dish: Dish, completion: @escaping BoolHandler)
    /// Добавляет слушателя изменений для объекта.
    func addDishListener(for object: AnyObject, _ block: @escaping DishHandler)
    /// Удаляет слушателя изменений для объекта.
    func removeListener(for object: AnyObject)
}

/// Cервис отвечающий за операции с базой данных
final class CoreDataService {
    // MARK: - Constants

    private enum Constants {
        static let uriPredicateFormat = "uri == %@"
        static let containerName = "CoreDataDish"
    }

    // MARK: - Public Properties

    var description: String {
        "CoreData service"
    }

    // MARK: - Private Properties

    private var listenersMap: [String: DishHandler] = [:]
    private lazy var container = {
        let container = NSPersistentContainer(name: Constants.containerName)
        container.loadPersistentStores { _, _ in }
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

    // MARK: - Private Methods

    private func isDishAlreadyExists(dish: Dish) -> Bool {
        let request = CDDish.fetchRequest()
        request.predicate = NSPredicate(format: Constants.uriPredicateFormat, dish.uri)
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
                guard !self.isDishAlreadyExists(dish: item) else { continue }
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
            request.predicate = NSPredicate(format: Constants.uriPredicateFormat, uri)
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

    func updateIsFavouriteStatus(forDish dish: Dish) {
        privateContext.perform {
            let request = CDDish.fetchRequest()
            request.predicate = NSPredicate(format: Constants.uriPredicateFormat, dish.uri)
            guard let cdDish = try? self.privateContext.fetch(request).first else { return }
            cdDish.isFavourite = dish.isFavourite
            do {
                try self.privateContext.save()
                try self.context.performAndWait {
                    try self.context.save()
                    self.listenersMap.values.forEach { $0(dish) }
                }
            } catch {}
        }
    }

    func getFavouriteDishes(_ completion: @escaping ([Dish]) -> ()) {
        privateContext.perform {
            let request = CDDish.fetchRequest()
            request.predicate = NSPredicate(format: "isFavourite == true")
            do {
                let results = try self.privateContext.fetch(request)
                let dishes = results.map { Dish(cdDish: $0) }
                completion(dishes)
            } catch {
                completion([])
            }
        }
    }

    func isDishFavourite(_ dish: Dish, completion: @escaping BoolHandler) {
        privateContext.perform {
            let request = CDDish.fetchRequest()
            request.predicate = NSPredicate(format: Constants.uriPredicateFormat, dish.uri)
            do {
                guard let cdDish = try self.privateContext.fetch(request).first else { return }
                completion(cdDish.isFavourite)
            } catch {
                completion(false)
            }
        }
    }

    func addDishListener(for object: AnyObject, _ block: @escaping DishHandler) {
        listenersMap[object.description] = block
    }

    func removeListener(for object: AnyObject) {
        listenersMap.removeValue(forKey: object.description)
    }
}
