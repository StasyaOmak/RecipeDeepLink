// Originator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Обьект управляющий текушим снапшотом пользовательских данных
final class Originator {
    // MARK: - Constants

    private enum Constants {
        static let userProfileImagesDirectoryURL = FileManager.default
            .getDirectory(withName: "UserProfileImages", inUserDomain: .cachesDirectory)
    }

    // MARK: - Public Properties

    var imageData: Data?
    var username: String?

    // MARK: - Initializers

    init(imageData: Data?, username: String?) {
        self.imageData = imageData
        self.username = username
    }

    // MARK: - Public Methods

    func save() -> UserMemento {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH.mm.ss"
        let imageName = "profileImage_" + formatter.string(from: Date())
        if let imageData,
           let url = Constants.userProfileImagesDirectoryURL?.appending(path: imageName).appendingPathExtension("png")
        // swiftlint:disable all
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
              let url = Constants.userProfileImagesDirectoryURL?.appending(path: imageName)
              .appendingPathExtension("png")
        else { return }
        do {
            let imageData = try Data(contentsOf: url)
            self.imageData = imageData
        } catch {
            print(error)
        }
    }
}
