// Originator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Originator {
    private enum Constants {
        static let logDirectoryURL = FileManager.default
            .getDirectory(withName: "UserProfileImages", inUserDomain: .cachesDirectory)
    }

    var imageData: Data?
    var username: String?

    init(imageData: Data?, username: String?) {
        self.imageData = imageData
        self.username = username
    }

    func save() -> UserMemento {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH.mm.ss"
        let imageName = "profileImage_" + formatter.string(from: Date())
        // swiftlint:disable all
        if let imageData,
           let url = Constants.logDirectoryURL?.appending(path: imageName).appendingPathExtension("png")
        {
            // swiftlint:enable all
            do {
                try imageData.write(to: url)
                return UserMemento(name: username, profileImageName: imageName)
            } catch {
                print(error)
            }
        }
        return UserMemento(name: username, profileImageName: nil)
    }

    func restore(memento: UserMemento) {
        username = memento.name

        guard let imageName = memento.profileImageName,
              let url = Constants.logDirectoryURL?.appending(path: imageName).appendingPathExtension("png")
        else { return }
        do {
            let imageData = try Data(contentsOf: url)
            self.imageData = imageData
        } catch {
            print(error)
        }
    }
}
