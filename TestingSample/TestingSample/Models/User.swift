//
//  User.swift
//  TestingSample
//
//  Created by Benoit PASQUIER on 16/08/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let email: String
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name &&
            lhs.email == rhs.email
    }
}
