//
//  main.swift
//  ComparisonCompactor
//
//  Created by boxjeon on 2018. 1. 9..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

class ComparisonCompactor {
    
    private static let ELLIPSIS = "..."
    private static let DELTA_END = "]"
    private static let DELTA_START = "["
    
    private var contextLength = 0
    private var expected: String?
    private var actual: String?
    private var compactExpected: String?
    private var compactActual: String?
    
    private var prefixLength: Int = 0
    private var suffixLength: Int = 0
    
    init(contextLength: Int, expected: String?, actual: String?) {
        self.contextLength = contextLength
        self.expected = expected
        self.actual = actual
    }
    
    func compact(message: String?) -> String {
        if self.canBeCompacted() {
            self.compactExpectedAndActual()
            return Assert.format(message, self.compactExpected, self.compactActual)
        } else {
            return Assert.format(message, self.expected, self.actual)
        }
    }
    
    private func canBeCompacted() -> Bool {
        return self.expected != nil && self.actual != nil && self.expected != self.actual
    }
    
    private func compactExpectedAndActual() {
        self.findCommonPrefixAndSuffix()
        self.compactExpected = self.compactString(self.expected)
        self.compactActual = self.compactString(self.actual)
    }
    
    private func findCommonPrefixAndSuffix() {
        self.findCommonPrefix()
        self.suffixLength = 0
        while !self.suffixOverlapsPrefix(suffixLength: self.suffixLength) {
            if self.charFromEnd(self.expected, self.suffixLength) != self.charFromEnd(self.actual, self.suffixLength) {
                break
            }
            self.suffixLength += 1
        }
    }
    
    private func findCommonPrefix() {
        guard let expected = self.expected, let actual = self.actual else { return }
        let end = min(expected.length, actual.length)
        self.prefixLength = 0
        while self.prefixLength < end {
            if expected[self.prefixLength] != actual[self.prefixLength] {
                break
            }
            self.prefixLength += 1
        }
    }
    
    private func charFromEnd(_ string: String?, _ distanceFromEnd: Int) -> Character? {
        guard let string = string else { return nil }
        return string[string.length - distanceFromEnd - 1]
    }
    
    private func suffixOverlapsPrefix(suffixLength: Int) -> Bool {
        return (self.actual?.length ?? 0) - self.suffixLength <= self.prefixLength || (self.expected?.length ?? 0) - self.suffixLength <= self.prefixLength
    }
    
    private func compactString(_ optionalSource: String?) -> String? {
        guard let source = optionalSource else { return optionalSource }
        var result = ComparisonCompactor.DELTA_START + source.substring(from: self.prefixLength, to: source.length - self.suffixLength) + ComparisonCompactor.DELTA_END
        if self.prefixLength > 0 {
            result = self.computeCommonPrefix() + result
        }
        if self.suffixLength > 0 {
            result = result + self.computeCommonSuffix()
        }
        return result
    }
    
    private func computeCommonPrefix() -> String {
        guard let expected = self.expected else { return "" }
        return (self.prefixLength > self.contextLength ? ComparisonCompactor.ELLIPSIS : "") + expected.substring(from: max(0, self.prefixLength - self.contextLength), to: self.prefixLength)
    }
    
    private func computeCommonSuffix() -> String {
        guard let expected = self.expected else { return "" }
        let end = min(expected.length - self.suffixLength + self.contextLength, expected.length)
        return expected.substring(from: expected.length - self.suffixLength, to: end) + (expected.length - self.suffixLength < expected.length - self.contextLength ? ComparisonCompactor.ELLIPSIS : "")
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

