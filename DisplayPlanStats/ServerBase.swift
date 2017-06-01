//
//  ServerBase.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation

struct ServerBase {

    static private(set) var baseAddress = "http://oralb.displayplan.digital"

    static func setBaseAddress(_ address: String) {
        baseAddress = address.trimmed
        UserDefaults.standard.set(address, forKey: UserDefaults.serverBaseAddress)
    }
}
