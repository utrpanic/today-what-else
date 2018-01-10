//
//  main.swift
//  ComparisonCompactor
//
//  Created by boxjeon on 2018. 1. 9..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

class ComparisonCompactor {
    
    private static let ellipsis = "..."
    private static let deltaEnd = "]"
    private static let deltaStart = "["
    
    private var contextLength = 0
    private var expected: String?
    private var actual: String?
    
    private var prefix: Int = 0
    private var suffix: Int = 0
    
    init(contextLength: Int, expected: String?, actual: String?) {
        self.contextLength = contextLength
        self.expected = expected
        self.actual = actual
    }
    
    func compact(message: String?) -> String {
        guard let expected = self.expected, let actual = self.actual, expected != actual else {
            return Assert.format(message, self.expected, self.actual)
        }
        self.findCommonPrefix()
        self.findCommonSuffix()
        let compactExpected = self.compactString(expected)
        let compactActual = self.compactString(actual)
        return Assert.format(message, compactExpected, compactActual)
    }
    
    private func findCommonPrefix() {
        guard let expected = self.expected, let actual = self.actual else { return }
        let end = min(expected.length, actual.length)
        self.prefix = 0
        for index in 0 ..< end {
            if expected[index] != actual[index] {
                break
            }
            self.prefix += 1
        }
    }
    
    private func findCommonSuffix() {
        guard let expected = self.expected, let actual = self.actual else { return }
        var expectedSuffix = expected.length - 1
        var actualSuffix = actual.length - 1
        while expectedSuffix >= self.prefix, actualSuffix >= self.prefix {
            if expected[expectedSuffix] != actual[actualSuffix] {
                break
            }
            expectedSuffix -= 1
            actualSuffix -= 1
        }
        self.suffix = expected.length - expectedSuffix
    }
    
    private func compactString(_ source: String) -> String {
        var result = ComparisonCompactor.deltaStart + source.substring(from: self.prefix, to: source.length - self.suffix + 1) + ComparisonCompactor.deltaEnd
        if self.prefix > 0 {
            result = self.computeCommonPrefix() + result
        }
        if self.suffix > 0 {
            result = result + self.computeCommonSuffix()
        }
        return result
    }
    
    private func computeCommonPrefix() -> String {
        guard let expected = self.expected else { return "" }
        return (self.prefix > self.contextLength ? ComparisonCompactor.ellipsis : "") + expected.substring(from: max(0, self.prefix - self.contextLength), to: self.prefix)
    }
    
    private func computeCommonSuffix() -> String {
        guard let expected = self.expected else { return "" }
        let end = min(expected.length - self.suffix + 1 + self.contextLength, expected.length)
        return expected.substring(from: expected.length - self.suffix + 1, to: end) + (expected.length - self.suffix + 1 < expected.length - self.contextLength ? ComparisonCompactor.ellipsis : "")
    }
    
}

class Assert {
    static func format(_ message: String?, _ expected: String?, _ actual: String?) -> String {
        var formattedMessage = ""
        if let message = message, message.length > 0 {
            formattedMessage += "\(message) "
        }
        formattedMessage += "expected:<\(expected ?? "nil")> "
        formattedMessage += "but was:<\(actual ?? "nil")>"
        return formattedMessage
    }
}

extension String {
    
    var length: Int { return self.utf16.count }
    
    subscript(_ index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    public func prefix(length: Int) -> String {
        guard 0 <= length else { return "" }
        guard length < self.length else { return self }
        return String(Substring(self.utf16.prefix(length)))
    }
    
    public func suffix(length: Int) -> String {
        guard 0 <= length else { return "" }
        guard length < self.length else { return self }
        return String(Substring(self.utf16.suffix(length)))
    }
    
    public func suffix(from: Int) -> String {
        guard 0 <= from else { return self }
        guard from < self.length else { return "" }
        return String(Substring(self.utf16.suffix(self.length - from)))
    }
    
    public func substring(from: Int, length: Int) -> String {
        return self.suffix(from: from).prefix(length: length)
    }
    
    public func substring(from: Int, to: Int) -> String {
        return self.prefix(length: to).suffix(from: from)
    }
    
}

