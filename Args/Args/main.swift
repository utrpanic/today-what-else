//
//  main.swift
//  Args
//
//  Created by boxjeon on 2018. 1. 11..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

class Args {
    
    
    
    
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
