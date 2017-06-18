//
//  UserDefaults.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation

extension UserDefaults {

    // MARK: user info keys
    struct User {
        static let name = "User Name"
        static let identifier = "User Identifier"
    }

    // MARK: server keys
    struct Server {
        static let baseAddress = "Server base address"
    }

    func save(_ model: ServerLoginModel) {
        set(model.identifier, forKey: UserDefaults.User.identifier)
        set(model.name, forKey: UserDefaults.User.name)
    }
}
