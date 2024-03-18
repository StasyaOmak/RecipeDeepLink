// UserDefaultsWrapper.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Враппер для удобного взаимодействия с UserDefaults для опциональных значений
@propertyWrapper
public struct UserDefault<T: Codable> {
    let key: String

    public var wrappedValue: T? {
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
            do {
                return try JSONDecoder().decode(T?.self, from: data)
            } catch {}
            return nil
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: key)
            } catch {}
        }
    }

    public init(wrappedValue: T? = nil, _ key: String) {
        self.key = key
        if wrappedValue != nil {
            self.wrappedValue = wrappedValue
        }
    }
}
