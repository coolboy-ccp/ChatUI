//
//  ChatUITests.swift
//  ChatUITests
//
//  Created by 储诚鹏 on 2018/7/4.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import XCTest
@testable import ChatUI

class ChatUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSize() {
        XCTAssertEqual(CGSize(width: 10, height: 20), CGSize((10,20)))
         XCTAssertNotEqual(CGSize(width: 10, height: 20), CGSize((10,10)))
    }
    
}
