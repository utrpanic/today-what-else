//
//  MessagePackEncoder.swift
//  MessagePackCoder
//
//  Created by boxjeon on 2018. 8. 14..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

public class MessagePackEncoder {
    
    public func encode<T>(_ value: T) throws -> Data where T: Encodable
}

class _MessagePackEncoder: Encoder {
    
    var codingPath: [CodingKey]
    
    var userInfo: [CodingUserInfoKey : Any]
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        <#code#>
    }
    
    func unkeyedContainer() -> UnkeyedContainer {
        <#code#>
    }
    
    func singleValueContainer() -> SingleValueContainer {
        <#code#>
    }
}

protocol MessagePackEncodingContainer {
    
    var data: Data { get }
}



class UnkeyedContainer: UnkeyedEncodingContainer
class KeyedContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey
