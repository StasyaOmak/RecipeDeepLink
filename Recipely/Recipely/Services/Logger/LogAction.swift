// LogAction.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
enum LogAction {
    static func log(_ line: String) {
        let command = LogCommand(line)
        LogInvoker.shared.addCommand(command)
        LogInvoker.shared.makeLog()
    }
}
