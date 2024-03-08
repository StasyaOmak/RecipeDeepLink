//
//  Logger.swift
//  Recipely
//
//  Created by Tixon Markin on 07.03.2024.
//

import Foundation


final class Logger {
    // MARK: - Constants
    
    private enum Constants {
        static let logDirectoryURL = FileManager.default.getDirectory(withName: "Logs", inUserDomain: .cachesDirectory)
    }
    
    // MARK: - Public Properties
    
    static let `default` = Logger()
    
    // MARK: - Private Properties
    
    private(set) var currentSessionLogFileName: String!
    
    // MARK: - Initializers
    
    private init() {
        startNewLog()
    }
    
    // MARK: - Public Methods
    func log(_ message: String) {
        let currentDateText = logDateFormatter.string(from: Date())
        let logLine = currentDateText + ": " + message + "\n"
        
        guard
            let data = logLine.data(using: .utf8),
            let url = Constants.logDirectoryURL?.appending(path: currentSessionLogFileName + ".txt")
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
    
    private let logDateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        return formatter
    }()
    
    func startNewLog() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH.mm.ss"
        currentSessionLogFileName = "session_" + formatter.string(from: Date())
    }
}
