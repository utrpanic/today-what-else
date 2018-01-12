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
        let arg = try! Args(schema: "l", args: ["-l"])
        XCTAssert(arg.getBoolean("l") == true)
    }
    
    func testInt() {
        let arg = try! Args(schema: "p#", args: ["-p", "5"])
        XCTAssert(arg.getInt("p") == 5)
    }
    
    func testString() {
        let arg = try! Args(schema: "d*", args: ["-d", "etc/"])
        XCTAssert(arg.getString("d") == "etc/")
    }
    
    func testWrongInvalidInteger() {
        do {
            let _ = try Args(schema: "p#", args: ["-p", "1a0"])
        } catch {
            XCTAssert((error as? ArgsError) == .invalidInteger )
        }
    }
    
    func testWrongMissingInteger() {
        do {
            let _ = try Args(schema: "p#", args: ["-p"])
        } catch {
            XCTAssert((error as? ArgsError) == .missingInteger )
        }
    }
    
    func testWrongMissingString() {
        do {
            let _ = try Args(schema: "d*", args: ["-d"])
        } catch {
            XCTAssert((error as? ArgsError) == .missingString )
        }
    }
    
    func testAll() {
        let arg = try! Args(schema: "l,p#,d*", args: ["-l", "-p", "10", "-d", "etc/"])
        XCTAssert(arg.getBoolean("l") == true)
        XCTAssert(arg.getInt("p") == 10)
        XCTAssert(arg.getString("d") == "etc/")
    }
    
}
