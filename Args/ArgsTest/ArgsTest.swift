//
//  ArgsTest.swift
//  ArgsTest
//
//  Created by boxjeon on 2018. 1. 11..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import XCTest

class ArgsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBoolean() {
        let arg = Args(schema: "l", args: ["-l"])
        XCTAssert(arg.getBoolean("l") == true)
    }
    
    func testInt() {
        let arg = Args(schema: "p#", args: ["-p10"])
        XCTAssert(arg.getInt("p") == 10)
    }
    
    func testDouble() {
        let arg = Args(schema: "k##", args: ["-k20.2"])
        XCTAssert(arg.getDouble("p") == 20.2)
    }
    
    func testString() {
        let arg = Args(schema: "d*", args: ["-detc/"])
        XCTAssert(arg.getString("d") == "etc/")
    }
    
//    func testStringArray() {
//        let arg = Args(schema: "w[*]", args: ["-detc/"])
//        XCTAssert(arg.getString("d") == "etc/")
//    }
    
    func testAll() {
        let arg = Args(schema: "l,p#,k##,d*", args: ["-l", "-p10", "-k20.2", "-detc/"])
        XCTAssert(arg.getBoolean("l") == true)
        XCTAssert(arg.getInt("p") == 10)
        XCTAssert(arg.getDouble("k") == 20.2)
        XCTAssert(arg.getString("d") == "etc/")
    }
    
}
