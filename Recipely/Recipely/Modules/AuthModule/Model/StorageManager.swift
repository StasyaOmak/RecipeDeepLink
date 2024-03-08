// StorageManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

//
///// Чтение и запись данных
// protocol StorageManagerProtocol {
//    ///  Запись в базу данных
//    func set(_ object: Any?, forKey key: StorageManager.Keys)
//    func set<T: Encodable>(object: T?, forKey key: StorageManager.Keys)
//
//    /// Чтение из базы данных
//    func int(forKey key: StorageManager.Keys) -> Int?
//    func string(forKey key: StorageManager.Keys) -> String?
//    func dict(forKey key: StorageManager.Keys) -> [String: Any]?
//    func date(forKey key: StorageManager.Keys) -> Date?
//    func bool(forKey key: StorageManager.Keys) -> Bool?
//    func data(forKey key: StorageManager.Keys) -> Data?
//    func codableData<T: Decodable>(forKey key: StorageManager.Keys) -> T?
// }
//
// final class StorageManager {
//    // MARK: - Types
//
//    public enum Keys: String {
//        case emailTextfield
//        case password
//    }
//
//    // MARK: - Public Properties
//
//    var databaseMap: [String: String] = [:]
//
//    // MARK: - Private Methods
//
//    private let userDefaults = UserDefaults.standard
//
//    // для записи данных
//    private func store(_ object: Any?, key: String) {
//        userDefaults.set(object, forKey: key)
//    }
//
//    // для восстановления данных
//    private func restore(forkey key: String) -> Any? {
//        userDefaults.object(forKey: key)
//    }
// }
//
// extension StorageManager: StorageManagerProtocol {
//    func set(_ object: Any?, forKey key: Keys) {
//        store(object, key: key.rawValue)
//        databaseMap.updateValue(key.rawValue, forKey: key.rawValue)
//        print(databaseMap)
//    }
//
//    func set<T>(object: T?, forKey key: Keys) where T: Encodable {
//        let jsonData = try? JSONEncoder().encode(object)
//        store(object, key: key.rawValue)
//    }
//
//    func int(forKey key: Keys) -> Int? {
//        restore(forkey: key.rawValue) as? Int
//    }
//
//    func string(forKey key: Keys) -> String? {
//        restore(forkey: key.rawValue) as? String
//    }
//
//    func dict(forKey key: Keys) -> [String: Any]? {
//        restore(forkey: key.rawValue) as? [String: Any]
//    }
//
//    func date(forKey key: Keys) -> Date? {
//        restore(forkey: key.rawValue) as? Date
//    }
//
//    func bool(forKey key: Keys) -> Bool? {
//        restore(forkey: key.rawValue) as? Bool
//    }
//
//    func data(forKey key: Keys) -> Data? {
//        restore(forkey: key.rawValue) as? Data
//    }
//
//    func codableData<T>(forKey key: Keys) -> T? where T: Decodable {
//        guard let data = restore(forkey: key.rawValue) as? Data else { return nil }
//        return try? JSONDecoder().decode(T.self, from: data)
//    }
//
//    func remove(forkey key: Keys) {
//        userDefaults.removeObject(forKey: key.rawValue)
//    }
// }
