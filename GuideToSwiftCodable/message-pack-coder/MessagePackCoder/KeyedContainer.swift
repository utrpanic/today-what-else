//
//  KeyedContainer.swift
//  MessagePackCoder
//
//  Created by boxjeon on 2018. 8. 15..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

class KeyedContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {
    
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    
    private var storage: [String: MessagePackEncodingContainer] = [:]
    
    private func nestedCodingPath(forKey key: CodingKey) -> [CodingKey] {
        return self.codingPath + [key]
    }
    
    private func nestedSingleValueContainer(forKey key: Key) -> SingleValueEncodingContainer {
        let container = SingleValueContainer(
            codingPath: self.nestedCodingPath(forKey: key),
            userInfo: self.userInfo
        )
        self.storage[key.stringValue] = container
        return container
    }
    
    init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.codingPath = codingPath
        self.userInfo = userInfo
    }
    
    func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        let container = UnkeyedContainer(
            codingPath: self.nestedCodingPath(forKey: key),
            userInfo: self.userInfo
        )
        self.storage[key.stringValue] = container
        return container
    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let container = KeyedContainer<NestedKey>(
            codingPath: self.nestedCodingPath(forKey: key),
            userInfo: self.userInfo
        )
        self.storage[key.stringValue] = container
        return KeyedEncodingContainer(container)
    }
    
    func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        var container = self.nestedSingleValueContainer(forKey: key)
        try container.encode(value)
    }
    
    func encodeNil(forKey key: Key) throws {
        var container = self.nestedSingleValueContainer(forKey: key)
        try container.encodeNil()
    }
    
    func superEncoder() -> Encoder {
        
    }
    
    func superEncoder(forKey key: Key) -> Encoder {
        
    }
}

extension KeyedContainer: MessagePackEncodingContainer {
    var data: Data {
        var data = Data()
        
        let length = storage.count
        if let uint16 = UInt16(exactly: length) {
            if length <= 15 {
                data.append(0x80 + UInt8(length))
            } else {
                data.append(0xdc)
                data.append(contentsOf: uint16.bytes)
            }
        } else if let uint32 = UInt32(exactly: length) {
            data.append(0xdd)
            data.append(contentsOf: uint32.bytes)
        } else {
            fatalError()
        }
        
        for (key, container) in self.storage {
            let keyContainer = SingleValueContainer(
                codingPath: self.codingPath,
                userInfo: self.userInfo
            )
            try! keyContainer.encode(key)
            data.append(keyContainer.data)
            data.append(container.data)
        }
        
        return data
    }
}
