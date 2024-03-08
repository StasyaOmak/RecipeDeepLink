// Originator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Хранение данных
struct Memento: Codable {
    /// Имя  пользователя
    var name: String?
    /// Изображение пользователя
    var profileImageData: Data?
}

///
final class Originator {
    var image: Data?
    var username: String?

    init(image: Data?, username: String?) {
        self.image = image
        self.username = username
    }

    func setNewUser(image: Data?, username: String?) {
        self.image = image
        self.username = username
    }

    func save() -> Memento {
        let memento = Memento(name: username, profileImageData: image)
        return memento
    }

    func restore(memento: Memento) {
        image = memento.profileImageData
        username = memento.name
    }
}

///
final class Caretaker {
    private lazy var mementos: [Memento] = []
    var originator: Originator?
    private let key = "name"

    func backup() {
        guard let memento = originator?.save() else { return }
        mementos.append(memento)
    }

    func undo() {
        guard !mementos.isEmpty else { return }
        let memento = mementos.removeLast()
        originator?.restore(memento: memento)
    }

    func save() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(mementos)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func getMementus() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        do {
            let decoder = JSONDecoder()
            mementos = try decoder.decode([Memento].self, from: data)
        } catch {
            print(error)
        }
    }
}
