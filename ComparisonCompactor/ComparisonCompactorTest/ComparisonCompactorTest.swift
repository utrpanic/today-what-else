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
        let failure = ComparisonCompactor(contextLength: 0, expected: "b", actual: "c").compact(message: "a")
        XCTAssert("a expected:<[b]> but was:<[c]>" == failure)
    }
    
    func testStartSame() {
        let failure = ComparisonCompactor(contextLength: 1, expected: "ba", actual: "bc").compact(message: nil)
        XCTAssert("expected:<b[a]> but was:<b[c]>" == failure)
    }
    
    func testEndSame() {
        let failure = ComparisonCompactor(contextLength: 1, expected: "ab", actual: "cb").compact(message: nil)
        XCTAssert("expected:<[a]b> but was:<[c]b>" == failure)
    }
    
    func testSame() {
        let failure = ComparisonCompactor(contextLength: 1, expected: "ab", actual: "ab").compact(message: nil)
        XCTAssert("expected:<ab> but was:<ab>" == failure)
    }
}
