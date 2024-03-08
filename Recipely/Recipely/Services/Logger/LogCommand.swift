// LogCommand.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Команда отвечающия за логирование
final class LogCommand: Command {
    private var logLine: String
    private var logger = Logger.default

    init(_ logLine: String) {
        self.logLine = logLine
    }

    func execute() {
        logger.log(logLine)
    }
}
