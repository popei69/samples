//
//  LoginFrameworkTests.swift
//  LoginFrameworkTests
//
//  Created by Benoit PASQUIER on 26/08/2019.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import XCTest
@testable import LoginFramework

class LoginFrameworkTests: XCTestCase {
    
    func testUserIsLoggedIn() {
        let user = User()
        XCTAssertFalse(user.isLoggedIn)
    }
}
