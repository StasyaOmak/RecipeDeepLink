// LogInvoker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Обьект исполняющий команды логирования
final class LogInvoker {
    private var commands: [Command] = []

    static let shared = LogInvoker()

    private init() {}

    func addCommand(_ command: Command) {
        commands.append(command)
    }

    func makeLog() {
        for command in commands {
            command.execute()
        }
        commands = []
    }
}
