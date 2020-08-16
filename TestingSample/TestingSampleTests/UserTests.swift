//
//  UserTests.swift
//  TestingSampleTests
//
//  Created by Benoit PASQUIER on 16/08/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import XCTest
@testable import TestingSample

class UserTests: XCTestCase {
    
    override func setUp() {
        executionTimeAllowance = 60
        continueAfterFailure = true
    }

    func testUserIsEqual() {
        executionTimeAllowance = 10
        let user1 = User(name: "name", email: "email")
        let user2 = User(name: "name", email: "email")
        
        XCTAssertEqual(user1, user2)
    }
    
    func testUserIsNotEqualByName() {
        
        let user1 = User(name: "name1", email: "email")
        let user2 = User(name: "name2", email: "email")
        
        XCTAssertNotEqual(user1, user2)
    }
    
    func testUserIsNotEqualByEmail() {
        let user1 = User(name: "name", email: "email1")
        let user2 = User(name: "name", email: "email2")
        
        XCTAssertNotEqual(user1, user2)
    }
    
    func testSomethingInLatestiOS() throws {
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .pad,
            "iPad only")
        
        
        XCTAssert(true)
    }
    
    func testUserIsNotEmpty() throws {
        let user = User(name: "", email: "")
        try assertNotEmpty(user)
    }
    
    func assertNotEmpty(_ user: User) throws {
        XCTAssertFalse(user.name.isEmpty)
        XCTAssertFalse(user.email.isEmpty)
    }

}
