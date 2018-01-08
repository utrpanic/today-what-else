//
//  ComparisonCompactorTest.swift
//  ComparisonCompactorTest
//
//  Created by boxjeon on 2018. 1. 9..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import XCTest

class ComparisonCompactorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMessage() {
        let failure = ComparisonCompactor(length: 0, expected: "b", actual: "c").compact(message: "a")
        assert("a expected:<[b]> but was:<[c]>" == failure)
    }
    
    func testStartSame() {
        let failure = ComparisonCompactor(length: 1, expected: "ba", actual: "bc").compact(message: nil)
        assert("a expected:<b[a]> but was:<b[c]>" == failure)
    }
    
}
