//
//  MessagePackEncoder.swift
//  MessagePackCoder
//
//  Created by boxjeon on 2018. 8. 14..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

public class MessagePackEncoder {
    
    public func encode<T>(_ value: T) throws -> Data where T: Encodable {
        let encoder = _MessagePackEncoder()
        try value.encode(to: encoder)
        return encoder.data
    }
}

class _MessagePackEncoder: Encoder {
    
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey: Any] = [:]
    
    var data: Data {
        return container?.data ?? Data()
    }
    
    fileprivate var container: MessagePackEncodingContainer? {
        willSet {
            precondition(self.container == nil)
        }
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        let container = KeyedContainer<Key>(
            codingPath: self.codingPath,
            userInfo: self.userInfo
        )
        self.container = container
        return KeyedEncodingContainer(container)
    }
    
    func unkeyedContainer() -> UnkeyedContainer {
        let container = UnkeyedContainer(
            codingPath: self.codingPath,
            userInfo: self.userInfo
        )
        self.container = container
        return container
    }
    
    func singleValueContainer() -> SingleValueContainer {
        let container = SingleValueContainer(
            codingPath: self.codingPath,
            userInfo: self.userInfo
        )
        self.container = container
        return container
    }
}

protocol MessagePackEncodingContainer {
    
    var data: Data { get }
}
