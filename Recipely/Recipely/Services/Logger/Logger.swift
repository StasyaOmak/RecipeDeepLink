// Logger.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Обьект занимающийся сохранением логов
final class Logger {
    // MARK: - Constants

    private enum Constants {
        static let logDirectoryURL = FileManager.default.getDirectory(withName: "Logs", inUserDomain: .cachesDirectory)
        static let dateFormatForNameOfLogFile = "yyyy-MM-dd'T'HH.mm.ss"
        static let sessionPrefixText = "session_"
    }

    // MARK: - Public Properties

    static let `default` = Logger()

    // MARK: - Private Properties

    private(set) var currentSessionLogFileName: String!
    private let logLineFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        return formatter
    }()

    // MARK: - Initializers

    init() {
        startNewLog()
    }

    // MARK: - Public Methods

    func log(_ message: String) {
        let currentDateText = logLineFormatter.string(from: Date())
        let logLine = currentDateText + ": " + message + "\n"

        guard
            let data = logLine.data(using: .utf8),
            let url = Constants.logDirectoryURL?.appending(path: currentSessionLogFileName)
            .appendingPathExtension(.txt)
        else { return }

        if let handle = try? FileHandle(forWritingTo: url) {
            handle.seekToEndOfFile()
            handle.write(data)
            handle.closeFile()
        } else {
            do {
                try data.write(to: url)
            } catch {
                print(error)
            }
        }
    }

    func startNewLog() {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormatForNameOfLogFile
        currentSessionLogFileName = Constants.sessionPrefixText + formatter.string(from: Date())
    }
}
