// DishesLoader.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Обьект занимающийся управление данных о блюдах в UserDefaults
final class DishesLoader {
    // MARK: - Constants

    private enum Constants {
        static let dishImagesDirURL = FileManager.default
            .getDirectory(withName: "DishesImages", inUserDomain: .cachesDirectory)
    }

    // MARK: - Private Properties

    @UserDefault("dishesIdsKeys") private var dishesKeys: [String: String]?

    // MARK: - Public Methods

    func loadDishes() -> [Dish] {
        let keys = dishesKeys
        let dishes = keys?.keys.compactMap { dishKey in
            getDish(byKey: dishKey)
        }
        guard let dishes else {
            let dishes = Dish.getDishes()
            saveMockDishes(dishes)
            return dishes
        }
        return dishes
    }

    func saveDish(_ dish: Dish) {
        saveImage(dish.imageData, withName: dish.id.uuidString)
        var memoryDish = MemoryDish(dish: dish)
        memoryDish.imageName = dish.id.uuidString
        do {
            let data = try JSONEncoder().encode(memoryDish)
            UserDefaults.standard.set(data, forKey: memoryDish.id.uuidString)
            dishesKeys?[memoryDish.id.uuidString] = memoryDish.name
        } catch {
            print(error)
        }
    }

//    func deleteDish(_ dish: Dish) {
//        do {
//            let data = try JSONEncoder().encode(dish)
//            UserDefaults.standard.removeObject(forKey: dish.id.description)
//            keys.removeValue(forKey: dish.id)
//        } catch {
//            print(error)
//        }
//    }

    // MARK: - Private Methods

    private func saveMockDishes(_ dishes: [Dish]) {
        dishes.forEach { saveDish($0) }
    }

    private func getDish(byKey key: String) -> Dish? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            let memoryDish = try JSONDecoder().decode(MemoryDish.self, from: data)
            var dish = memoryDish.makeDish()
            dish.imageData = getImage(withName: memoryDish.imageName ?? "")
            return dish
        } catch {
            print(error)
        }
        return nil
    }

    func saveImage(_ data: Data?, withName name: String) {
        guard let data,
              let url = Constants.dishImagesDirURL?.appending(path: name).appendingPathExtension("png"),
              !FileManager.default.fileExists(atPath: url.path())
        else { return }
        do {
            try data.write(to: url)
        } catch {
            print(error)
        }
    }

    func getImage(withName name: String) -> Data? {
        guard let url = Constants.dishImagesDirURL?.appending(path: name).appendingPathExtension("png")
        else { return nil }
        do {
            let imageData = try Data(contentsOf: url)
            return imageData
        } catch {
            print(error)
        }
        return nil
    }
}
