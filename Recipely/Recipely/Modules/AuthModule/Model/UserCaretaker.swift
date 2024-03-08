// UserCaretaker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
final class UserCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "key"

    static var `default` = UserCaretaker()

    private init() {}

    func save(_ user: UserAuthData) {
        do {
            let data = try encoder.encode(user)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func getUser() -> UserAuthData? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            return try decoder.decode(UserAuthData.self, from: data)
        } catch {
            return nil
        }
    }
}
