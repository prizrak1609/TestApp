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
    static let userName = "User Name"
    static let userIdentifier = "User Identifier"

    // MARK: server keys
    static let serverBaseAddress = "Server base address"

    func save(_ model: ServerLoginModel) {
        set(model.identifier, forKey: UserDefaults.userIdentifier)
        set(model.name, forKey: UserDefaults.userName)
    }
}
