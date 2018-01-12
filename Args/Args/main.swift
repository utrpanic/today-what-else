//
//  main.swift
//  Args
//
//  Created by boxjeon on 2018. 1. 11..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

class Args {
    
    private var schema: String
    private var args: Array<String>
    private var valid: Bool = true
    private var marshalers = Dictionary<Character, ArgumentMarshaler>()
    private var argsFound = Set<Character>()
    
    private var currentArgument: Iterator
    
    init(schema: String, args: Array<String>) throws {
        self.schema = schema
        self.args = args
        self.currentArgument = args.makeIterator()
        self.valid = try self.parse()
    }
    
    private func parse() throws -> Bool {
        guard self.schema.length > 0, self.args.count > 0 else { return true }
        try self.parseSchema()
        try self.parseArguments()
        return self.valid
    }
    
    private func parseSchema() throws {
        try self.schema.split(separator: ",").forEach({
            let trimmedElement = $0.trimmingCharacters(in: .whitespaces)
            if trimmedElement.length > 0 {
                try self.parseSchemaElement(trimmedElement)
            }
        })
    }
    
    private func parseSchemaElement(_ element: String) throws {
        let elementId = element[0]
        let tail = element.suffix(from: 1)
        try self.validateSchemaElementId(elementId)
        if self.isBooleanSchemaElement(tail) {
            self.parseBooleanSchemaElement(elementId)
        } else if self.isIntegerSchemaElement(tail) {
            self.parseIntegerSchemaElement(elementId)
        } else if self.isStringSchemaElement(tail) {
            self.parseStringSchemaElement(elementId)
        } else {
            throw ArgsError.invalidArgumentFormat
        }
    }
    
    private func validateSchemaElementId(_ elementId: Character) throws {
        if let unicodeScalar = elementId.unicodeScalars.first, CharacterSet.letters.contains(unicodeScalar) {
            // do nothing.
        } else {
            throw ArgsError.invalidArgumentFormat
        }
    }
    
    private func isBooleanSchemaElement(_ element: String) -> Bool {
        return element.length == 0
    }
    
    private func isIntegerSchemaElement(_ element: String) -> Bool {
        return element == "#"
    }
    
    private func isStringSchemaElement(_ element: String) -> Bool {
        return element == "*"
    }
    
    private func parseBooleanSchemaElement(_ elementId: Character) {
        self.marshalers[elementId] = BooleanArgumentMarshaler()
    }
    
    private func parseIntegerSchemaElement(_ elementId: Character) {
        self.marshalers[elementId] = IntegerArgumentMarshaler()
    }
    
    private func parseStringSchemaElement(_ elementId: Character) {
        self.marshalers[elementId] = StringArgumentMarshaler()
    }
    
    private func parseArguments() throws {
        while let argument = self.currentArgument.next() {
            try self.parseArgument(argument)
        }
    }
    
    private func parseArgument(_ argument: String) throws {
        if argument.starts(with: "-") {
            try self.parseElements(argument)
        }
    }
    
    private func parseElements(_ elements: String) throws {
        for index in 1 ..< elements.length {
            try self.parseElement(elements[index])
        }
    }
    
    private func parseElement(_ element: Character) throws {
        if try self.setArgument(element) {
            self.argsFound.insert(element)
        } else {
            self.valid = false
        }
    }
    
    private func setArgument(_ argument: Character) throws -> Bool {
        if let marshaler = self.marshalers[argument] {
            self.currentArgument = try marshaler.set(self.currentArgument)
            return true
        } else {
            return false
        }
    }
    
    func getBoolean(_ character: Character) -> Bool {
        return (self.marshalers[character] as? BooleanArgumentMarshaler)?.value ?? false
    }
    
    func getInt(_ character: Character) -> Int {
        return (self.marshalers[character] as? IntegerArgumentMarshaler)?.value ?? 0
    }
    
    func getDouble(_ character: Character) -> Double {
        return 20.2
    }
    
    func getString(_ character: Character) -> String {
        return (self.marshalers[character] as? StringArgumentMarshaler)?.value ?? ""
    }
}


protocol ArgumentMarshaler {
    func set(_ iterator: Iterator) throws -> Iterator
}

class BooleanArgumentMarshaler: ArgumentMarshaler {
    var value: Bool = false
    func set(_ iterator: Iterator) throws -> Iterator {
        self.value = true
        return iterator
    }
}

class IntegerArgumentMarshaler: ArgumentMarshaler {
    var value: Int = 0
    func set(_ iterator: Iterator) throws -> Iterator {
        var iterator = iterator
        if let argument = iterator.next() {
            if let value = Int(argument) {
                self.value = value
                return iterator
            } else {
                throw ArgsError.invalidInteger
            }
        } else {
            throw ArgsError.missingInteger
        }
    }
}

class StringArgumentMarshaler: ArgumentMarshaler {
    var value: String = ""
    func set(_ iterator: Iterator) throws -> Iterator {
        var iterator = iterator
        if let value = iterator.next() {
            self.value = value
            return iterator
        } else {
            throw ArgsError.missingString
        }
    }
}

enum ArgsError: Error {
    case ok
    case invalidArgumentFormat
    case unexpectedArgument
    case invalidArgumentName
    case missingString
    case missingInteger
    case invalidInteger
    case missingDouble
    case invalidDouble
}

typealias Iterator = IndexingIterator<Array<String>>

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
