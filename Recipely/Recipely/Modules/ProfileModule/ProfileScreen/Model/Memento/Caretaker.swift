// Caretaker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Обьект занимающийся управлением снапшотами пользовательских данных
final class Caretaker {
    // MARK: - Public Properties

    var originator: Originator?

    // MARK: - Private Properties

    private lazy var mementos: [UserMemento] = []
    private let key = "mementoStore"

    // MARK: - Public Methods

    func backup() {
        guard let memento = originator?.save() else { return }
        mementos.append(memento)
    }

    func undo() {
        guard !mementos.isEmpty else { return }
        let memento = mementos.removeLast()
        originator?.restore(memento: memento)
    }

    func lastState() {
        guard !mementos.isEmpty,
              let memento = mementos.last
        else { return }
        originator?.restore(memento: memento)
    }

    func save() {
        DispatchQueue.global(qos: .userInitiated).async(flags: .barrier) {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(self.mementos)
                UserDefaults.standard.set(data, forKey: self.key)
            } catch {}
        }
    }

    func fetch() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        do {
            let decoder = JSONDecoder()
            mementos = try decoder.decode([UserMemento].self, from: data)
        } catch {}
    }
}
