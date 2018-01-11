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
    private var booleanArgs = Dictionary<Character, BooleanArgumentMarshaler>()
    private var integerArgs = Dictionary<Character, IntegerArgumentMarshaler>()
    private var stringArgs = Dictionary<Character, StringArgumentMarshaler>()
    private var argsFound = Set<Character>()
    
    private var currentArgument: Int = 0
    
    init(schema: String, args: Array<String>) throws {
        self.schema = schema
        self.args = args
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
        self.booleanArgs[elementId] = BooleanArgumentMarshaler()
    }
    
    private func parseIntegerSchemaElement(_ elementId: Character) {
        self.integerArgs[elementId] = IntegerArgumentMarshaler()
    }
    
    private func parseStringSchemaElement(_ elementId: Character) {
        self.stringArgs[elementId] = StringArgumentMarshaler()
    }
    
    private func parseArguments() throws -> Bool {
        self.currentArgument = 0
        while self.currentArgument < self.args.count {
            try self.parseArgument(self.args[self.currentArgument])
            self.currentArgument += 1
        }
        return true
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
        if self.isBooleanArgument(argument) {
            try self.setBooleanArg(argument)
        } else if self.isIntegerArgument(argument) {
            try self.setIntegerArg(argument)
        } else if self.isStringArgument(argument) {
            try self.setStringArg(argument)
        } else {
            return false
        }
        return true
    }
    
    private func isBooleanArgument(_ argument: Character) -> Bool {
        return self.booleanArgs[argument] != nil
    }
    
    private func isIntegerArgument(_ argument: Character) -> Bool {
        return self.integerArgs[argument] != nil
    }
    
    private func isStringArgument(_ argument: Character) -> Bool {
        return self.stringArgs[argument] != nil
    }
    
    private func setBooleanArg(_ argument: Character) throws {
        try self.booleanArgs[argument]?.set(nil)
    }
    
    private func setIntegerArg(_ argument: Character) throws {
        self.currentArgument += 1
        if self.currentArgument < self.args.count {
            try self.integerArgs[argument]?.set(self.args[self.currentArgument])
        } else {
            self.valid = false
            throw ArgsError.missingInteger
        }
    }
    
    private func setStringArg(_ argument: Character) throws {
        self.currentArgument += 1
        if self.currentArgument < self.args.count {
            try self.stringArgs[argument]?.set(self.args[self.currentArgument])
        } else {
            self.valid = false
            throw ArgsError.missingString
        }
    }
    
    func getBoolean(_ character: Character) -> Bool {
        return self.booleanArgs[character]?.value ?? false
    }
    
    func getInt(_ character: Character) -> Int {
        return self.integerArgs[character]?.value ?? 0
    }
    
    func getDouble(_ character: Character) -> Double {
        return 20.2
    }
    
    func getString(_ character: Character) -> String {
        return self.stringArgs[character]?.value ?? ""
    }
}


class ArgumentMarshaler<T> {
    var value: T?
    func set(_ argument: String?) throws {
        assertionFailure("must implement")
    }
}

class BooleanArgumentMarshaler: ArgumentMarshaler<Bool> {
    override func set(_ argument: String?) throws {
        self.value = true
    }
}

class IntegerArgumentMarshaler: ArgumentMarshaler<Int> {
    override func set(_ argument: String?) throws {
        if let argument = argument {
            if let value = Int(argument) {
                self.value = value
            } else {
                throw ArgsError.invalidInteger
            }
        } else {
            throw ArgsError.missingInteger
        }
    }
}

class StringArgumentMarshaler: ArgumentMarshaler<String> {
    override func set(_ argument: String?) throws {
        if let value = argument {
            self.value = value
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
