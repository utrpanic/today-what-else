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
    
    func testNoContextStartAndEndSame() {
        let failure = ComparisonCompactor(contextLength: 0, expected: "abc", actual: "adc").compact(message: nil)
        XCTAssert("expected:<...[b]...> but was:<...[d]...>" == failure)
    }
    
    func testStartAndEndContext() {
        let failure = ComparisonCompactor(contextLength: 1, expected: "abc", actual: "adc").compact(message: nil)
        XCTAssert("expected:<a[b]c> but was:<a[d]c>" == failure)
    }
    
    func testStartAndEndContextWithEllipses() {
        let failure = ComparisonCompactor(contextLength: 1, expected: "abcde", actual: "abfde").compact(message: nil)
        XCTAssert("expected:<...b[c]d...> but was:<...b[f]d...>" == failure)
    }
    
    func testComparisonErrorStartSameComplete() {
        let failure = ComparisonCompactor(contextLength: 2, expected: "ab", actual: "abc").compact(message: nil)
        XCTAssert("expected:<ab[]> but was:<ab[c]>" == failure)
    }
    
    func testComparisonErrorEndSameComplete() {
        let failure = ComparisonCompactor(contextLength: 0, expected: "bc", actual: "abc").compact(message: nil)
        XCTAssert("expected:<[]...> but was:<[a]...>" == failure)
    }
    
    func testComparisonErrorEndSameCompleteContext() {
        let failure = ComparisonCompactor(contextLength: 2, expected: "bc", actual: "abc").compact(message: nil)
        XCTAssert("expected:<[]bc> but was:<[a]bc>" == failure)
    }
    
    func testComparionsError() {
        let failure = ComparisonCompactor(contextLength: 2, expected: "bc", actual: "abc").compact(message: nil)
        XCTAssert("expected:<[]bc> but was:<[a]bc>" == failure)
    }
    
    func testComparionsErrorOverlapingMatches() {
        let failure = ComparisonCompactor(contextLength: 0, expected: "abc", actual: "abbc").compact(message: nil)
        XCTAssert("expected:<...[]...> but was:<...[b]...>" == failure)
    }
    
    func testComparionsErrorOverlapingMatchesContext() {
        let failure = ComparisonCompactor(contextLength: 2, expected: "abc", actual: "abbc").compact(message: nil)
        XCTAssert("expected:<ab[]c> but was:<ab[b]c>" == failure)
    }
    
    func testComparionsErrorOverlapingMatches2() {
        let failure = ComparisonCompactor(contextLength: 0, expected: "abcdde", actual: "abcde").compact(message: nil)
        XCTAssert("expected:<...[d]...> but was:<...[]...>" == failure)
    }
    
    func testComparionsErrorOverlapingMatches2Context() {
        let failure = ComparisonCompactor(contextLength: 2, expected: "abcdde", actual: "abcde").compact(message: nil)
        XCTAssert("expected:<...cd[d]e> but was:<...cd[]e>" == failure)
    }
    
    func testComparionsErrorWithActualNil() {
        let failure = ComparisonCompactor(contextLength: 0, expected: "a", actual: nil).compact(message: nil)
        XCTAssert("expected:<a> but was:<nil>" == failure)
    }
    
    func testComparionsErrorWithActualNilContext() {
        let failure = ComparisonCompactor(contextLength: 2, expected: "a", actual: nil).compact(message: nil)
        XCTAssert("expected:<a> but was:<nil>" == failure)
    }
    
    func testComparionsErrorWithExpectedNil() {
        let failure = ComparisonCompactor(contextLength: 0, expected: nil, actual: "a").compact(message: nil)
        XCTAssert("expected:<nil> but was:<a>" == failure)
    }
    
    func testComparionsErrorWithExpectedNilContext() {
        let failure = ComparisonCompactor(contextLength: 2, expected: nil, actual: "a").compact(message: nil)
        XCTAssert("expected:<nil> but was:<a>" == failure)
    }
    
    func testBug609972() {
        let failure = ComparisonCompactor(contextLength: 10, expected: "S&P500", actual: "0").compact(message: nil)
        XCTAssert("expected:<[S&P50]0> but was:<[]0>" == failure)
    }
}
