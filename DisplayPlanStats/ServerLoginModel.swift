//
//  ServerLoginModel.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ServerLoginModel {

    let success: Bool
    let name: String
    let identifier: String

    init(json: JSON) {
        success = json["success"].boolValue
        name = json["data"]["full_name"].stringValue
        identifier = json["data"]["identifier"].stringValue
    }
}
