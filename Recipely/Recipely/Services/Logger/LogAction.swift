// LogAction.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Обертка для удобного добавления команд логирования в LogInvoker
enum LogAction {
    static func log(_ line: String) {
        let command = LogCommand(line)
        LogInvoker.shared.addCommand(command)
        LogInvoker.shared.makeLog()
    }
}
