//
//  Logger.swift
//
//  Version 0.0.1
//
//  Created by Oleksii Mykhailenko on 11/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

struct Logger {
    
    /// return date formatter
    static var dateFormatter: DateFormatter {
        let dateFormat = "yyyy-MM-dd.hh"
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
    
    /// Return url of log file
    static var logFile: URL {
        let fileManager = FileManager.default
        let file = fileManager.urls(for: .documentDirectory,
                                    in: .userDomainMask)[0].appendingPathComponent("log-\(dateFormatter.string(from: Date())).txt")
        return file
    }
    
    
    /// Write string to the logFile
    ///
    /// - Parameters:
    ///   - text: Log strings
    ///   - file: project file name
    ///   - line: line in project file
    ///   - function: function in project file
    static func write(_ text: String,
                      file: String = #file,
                      line: Int = #line,
                      function: String = #function) {
        let log = """
        ####################
        \(Date())
        \(file) line: \(line)
        \(function)
        ####################
        \(text)
        ####################
        """
        if let handle = try? FileHandle(forWritingTo: Logger.logFile) {
            handle.seekToEndOfFile()
            handle.write(log.data(using: .utf8)!)
            handle.closeFile()
        } else {
            try? log.data(using: .utf8)?.write(to: Logger.logFile)
        }
    }
    
    /// Remove log files older than X days.
    ///
    /// - Parameter days: set count of X days.
    static func removeOlderThan(days: Int) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                var str: String = fileURL.lastPathComponent
                str = String(str.dropFirst(4))
                str = String(str.dropLast(4))
                let fileDate = Logger.dateFormatter.date(from: str)
                let oldDate = Calendar.current.date(byAdding: .day, value: -days, to: Date())
                if fileDate ?? Date() < oldDate ?? Date() {
                    do {
                        try fileManager.removeItem(at: fileURL)
                    } catch {
                        print("Can't remove file: \(fileURL.absoluteString)")
                    }
                }
            }
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
}
