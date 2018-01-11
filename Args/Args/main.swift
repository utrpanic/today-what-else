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
    
    init(schema: String, args: Array<String>) {
        self.schema = schema
        self.args = args
        self.valid = self.parse()
    }
    
    private func parse() -> Bool {
        guard self.schema.length > 0, self.args.count > 0 else { return true }
        self.parseSchema()
        self.parseArguments()
        return self.valid
    }
    
    private func parseSchema() {
        self.schema.split(separator: ",").forEach({
            let trimmedElement = $0.trimmingCharacters(in: .whitespaces)
            if trimmedElement.length > 0 {
                self.parseSchemaElement(trimmedElement)
            }
        })
    }
    
    private func parseSchemaElement(_ element: String) {
        let elementId = element[0]
        let tail = element.suffix(from: 1)
        try! self.validateSchemaElementId(elementId)
    }
    
    private func validateSchemaElementId(_ elementId: Character) throws {
        if let unicodeScalars = elementId.unicodeScalars.first, CharacterSet.letters.contains(unicodeScalars) {
            // do nothing.
        } else {
            throw ArgsError.invalidArgumentFormat
        }
    }
    
    private func parseArguments() {
        
    }
    
    func getBoolean(_ character: Character) -> Bool {
        return true
    }
    
    func getInt(_ character: Character) -> Int {
        return 10
    }
    
    func getDouble(_ character: Character) -> Double {
        return 20.2
    }
    
    func getString(_ character: Character) -> String {
        return "etc/"
    }
}





















protocol ArgumentMarshaler {
    func set() throws
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
