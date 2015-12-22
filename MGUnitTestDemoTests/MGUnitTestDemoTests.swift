//
//  MGUnitTestDemoTests.swift
//  MGUnitTestDemoTests
//
//  Created by Tuan Truong on 12/17/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import XCTest
@testable import MGUnitTestDemo

class MGUnitTestDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let userService = UserService()
        let result = userService.addUser(User())
        XCTAssert(result)

    }
}
