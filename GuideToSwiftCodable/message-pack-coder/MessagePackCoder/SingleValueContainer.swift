//
//  SingleValueContainer.swift
//  MessagePackCoder
//
//  Created by boxjeon on 2018. 8. 14..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

class SingleValueContainer: SingleValueEncodingContainer, MessagePackEncodingContainer {
    
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    
    var data: Data {
        return self.storage
    }
    
    private var storage: Data = Data()
    fileprivate var canEncodeNewValue = true
    fileprivate func checkCanEncode(value: Any?) throws {
        guard self.canEncodeNewValue else {
            let context = EncodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Cannot encode multiple values."
            )
            throw EncodingError.invalidValue(value as Any, context)
        }
    }
    
    init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey: Any]) {
        self.codingPath = codingPath
        self.userInfo = userInfo
    }
    
    func encodeNil() throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        storage.append(0xc0)
    }
    
    func encode(_ value: Bool) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        switch value {
        case false:
            storage.append(0xc2)
        case true:
            storage.append(0xc3)
        }
    }
    
    func encode(_ value: Float) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xca)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: Double) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xcb)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: UInt8) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xcc)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: UInt16) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xcd)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: UInt32) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xce)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: UInt64) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xcf)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: Int8) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xd0)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: Int16) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xd1)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: Int32) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xd2)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: Int64) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        storage.append(0xd3)
        storage.append(contentsOf: value.bytes)
    }
    
    func encode(_ value: Int) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        if let int8 = Int8(exactly: value) {
            if (int8 >= 0 && int8 <= 127) {
                self.storage.append(UInt8(int8))
            } else if (int8 < 0 && int8 >= -31) {
                self.storage.append(0xe0 +
                    (0x1f & UInt8(truncatingIfNeeded: int8))
                )
            } else {
                try encode(int8)
            }
        } else if let int16 = Int16(exactly: value) {
            try encode(int16)
        } else if let int32 = Int32(exactly: value) {
            try encode(int32)
        } else if let int64 = Int64(exactly: value) {
            try encode(int64)
        } else {
            let context = EncodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Cannot encode integer \(value)."
            )
            throw EncodingError.invalidValue(value, context)
        }
    }
    
    // TODO: 확인 필요.
    func encode(_ value: UInt) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        if let uint8 = UInt8(exactly: value) {
            try encode(uint8)
        } else if let uint16 = UInt16(exactly: value) {
            try encode(uint16)
        } else if let uint32 = UInt32(exactly: value) {
            try encode(uint32)
        } else if let uint64 = UInt64(exactly: value) {
            try encode(uint64)
        } else {
            let context = EncodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Cannot encode unsigned integer \(value)."
            )
            throw EncodingError.invalidValue(value, context)
        }
    }
    
    // TODO: 확인 필요.
    func encode<T>(_ value: T) throws where T : Encodable {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        
    }

    func encode(_ value: String) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let data = value.data(using: .utf8) else {
            let context = EncodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Cannot encode as UTF-8."
            )
            throw EncodingError.invalidValue(value, context)
        }
        
        let length = data.count
        if let uint8 = UInt8(exactly: length) {
            if (uint8 <= 31) {
                self.storage.append(0xa0 + uint8)
            } else {
                self.storage.append(0xd9)
                self.storage.append(contentsOf: uint8.bytes)
            }
        } else if let uint16 = UInt16(exactly: length) {
            self.storage.append(0xda)
            self.storage.append(contentsOf: uint16.bytes)
        } else if let uint32 = UInt32(exactly: length) {
            self.storage.append(0xdb)
            self.storage.append(contentsOf: uint32.bytes)
        } else {
            let context = EncodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Cannot encode string with length \(length)."
            )
            throw EncodingError.invalidValue(value, context)
        }
        
        self.storage.append(data)
    }
}

extension FixedWidthInteger {
    
    var bytes: [UInt8] {
        let capacity = MemoryLayout<Self>.size
        var mutableValue = self.bigEndian
        return withUnsafePointer(to: &mutableValue) {
            return $0.withMemoryRebound(to: UInt8.self, capacity: capacity) {
                return Array(UnsafeBufferPointer(start: $0, count: capacity))
            }
        }
    }
}

extension Float {
    
    var bytes: [UInt8] {
        return self.bitPattern.bytes
    }
}

extension Double {
    var bytes: [UInt8] {
        return self.bitPattern.bytes
    }
}
