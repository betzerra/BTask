//
//  Log.swift
//  BGTask
//
//  Created by Ezequiel Becerra on 26/08/2025.
//

import Foundation
import Logging
import Puppy

class Log {
    private static let shared = Log()
    private let logFormatter = LogFormatter()
    private let logger: Logger

    private static var logFile: URL {
        let docsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docsDir
            .appendingPathComponent("app")
            .appendingPathExtension("log")
    }

    init() {
        let consoleLogger = ConsoleLogger(
            "com.betzerra.BGTask.logger.console",
            logLevel: .debug,
            logFormat: logFormatter
        )

        let fileLogger = try? FileLogger(
            "com.betzerra.BGTask.logger.console",
            logLevel: .debug,
            logFormat: logFormatter,
            fileURL: Self.logFile
        )

        var loggers: [Loggerable] = [consoleLogger]
        if let fileLogger = fileLogger {
            loggers.append(fileLogger)
        }

        let puppy = Puppy(loggers: loggers)

        LoggingSystem.bootstrap {
            var handler = PuppyLogHandler(label: $0, puppy: puppy)
            handler.logLevel = .debug
            return handler
        }

        logger = Logger(label: "com.betzerra.BGTask.logger")
    }

    static func debug(_ message: Logger.Message) {
        Self.shared.logger.debug(message)
    }

    static func info(_ message: Logger.Message) {
        Self.shared.logger.info(message)
    }
}

final class LogFormatter: LogFormattable {
    let formatter = DateFormatter()

    init() {}

    func formatMessage(_ level: LogLevel, message: String, tag: String, function: String, file: String, line: UInt, swiftLogInfo: [String: String], label: String, date: Date, threadID: UInt64) -> String {
        let date = dateFormatter(date, withFormatter: formatter, timeZone: "UTC")
        let file = URL(fileURLWithPath: file).deletingPathExtension().lastPathComponent
        return "\(date) [\(level.emoji) \(level)] \(file) \(function) \(message)"
    }
}
