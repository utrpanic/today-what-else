//
//  UnkeyedContainer.swift
//  MessagePackCoder
//
//  Created by boxjeon on 2018. 8. 15..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

class UnkeyedContainer: UnkeyedEncodingContainer {
    
    var codingPath: [CodingKey]
    var count: Int { return storage.count }
    
    var userInfo: [CodingUserInfoKey: Any]
    
    struct Index: CodingKey {
        
        var intValue: Int?
        
        var stringValue: String {
            return "\(self.intValue!)"
        }
        
        init?(intValue: Int) {
            self.intValue = intValue
        }
        
        init?(stringValue: String) {
            return nil
        }
    }
    
    private var nestedCodingPath: [CodingKey] {
        return self.codingPath + [Index(intValue: self.count)!]
    }
    
    private var storage: [MessagePackEncodingContainer] = []
    
    private func nestedSingleValueContainer() -> SingleValueEncodingContainer {
        let container = SingleValueContainer(
            codingPath: self.nestedCodingPath,
            userInfo: self.userInfo
        )
        self.storage.append(container)
        return container
    }
    
    init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.codingPath = codingPath
        self.userInfo = userInfo
    }
    
    func encode<T>(_ value: T) throws where T : Encodable {
        var container = self.nestedSingleValueContainer()
        try container.encode(value)
    }
    
    func encodeNil() throws {
        var container = self.nestedSingleValueContainer()
        try container.encodeNil()
    }
    
    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        let container = UnkeyedContainer(
            codingPath: self.nestedCodingPath,
            userInfo: self.userInfo
        )
        self.storage.append(container)
        return container
    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let container = KeyedContainer<NestedKey>(
            codingPath: self.nestedCodingPath,
            userInfo: self.userInfo
        )
        self.storage.append(container)
        return KeyedEncodingContainer(container)
    }
    
    func superEncoder() -> Encoder {
        
    }
}

extension UnkeyedContainer: MessagePackEncodingContainer {
    
    var data: Data {
        var data = Data()
        
        let length = storage.count
        if let uint16 = UInt16(exactly: length) {
            if uint16 <= 15 {
                data.append(UInt8(0x90 + uint16))
            } else {
                data.append(0xdc)
                data.append(contentsOf: uint16.bytes)
            }
        } else if let uint32 = UInt32(exactly: length) {
            data.append(0xdc)
            data.append(contentsOf: uint32.bytes)
        } else {
            fatalError()
        }
        
        for container in storage {
            data.append(container.data)
        }
        
        return data
    }
}
