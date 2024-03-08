// Caretaker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Caretaker {
    private lazy var mementos: [UserMemento] = []
    var originator: Originator?
    private let key = "mementoStore"

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
            } catch {
                print(error)
            }
        }
    }

    func getMementus() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        do {
            let decoder = JSONDecoder()
            mementos = try decoder.decode([UserMemento].self, from: data)
        } catch {
            print(error)
        }
    }
}
