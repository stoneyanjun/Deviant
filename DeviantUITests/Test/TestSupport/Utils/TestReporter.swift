//
//  TestReporter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import XCTest

public class TestReporter {
    public struct Level: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let console = Level(rawValue: 1 << 0)

        public static let file = Level(rawValue: 1 << 1)

        public static let silent: Level = []

        public static let verbose: Level = [.console, .file]
    }

    static let reportOutputPathEnvironmentVariableKey: String = "TEST_REPROT_OUTPUT_PATH"

    public static var level: Level = .console

    public static func report(testFile: String, message: String) {
        if TestReporter.level.contains(.console) {
            print("testFile: \(testFile) - function: \(message)")
        }

        if TestReporter.level.contains(.file) {
            TestReporter.write(testFile: testFile, function: message)
        }
    }

    private static let basePath: NSString = {
        NSString(string: ProcessInfo.processInfo.environment[reportOutputPathEnvironmentVariableKey] ?? "")
    }()

    private static func write(testFile: String, function: String) {
        let stepString = function + "\n"
        let fileUrl = URL(fileURLWithPath: basePath.appendingPathComponent("\(testFile).raw"))

        guard let data = stepString.data(using: .utf8) else {
            fatalError("Non UTF-8 compatible string: \(stepString)")
        }

        if let fileHandle = FileHandle(forWritingAtPath: fileUrl.path) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
        } else {
            try? stepString.write(to: fileUrl, atomically: false, encoding: .utf8)
        }
    }
}

public extension XCTestCase {
    func report(function: String) {
        TestReporter.report(testFile: NSStringFromClass(classForCoder), message: function)
    }
}
