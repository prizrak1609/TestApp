//
//  ServerMainVCModel.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ServerCampainStatus : Int {
    case unpublished = 0
    case published = 1
    case cancelled = 2
}

enum ServerCampainType : Int {
    case video = 1
    case liftNLearn = 2
    case touch = 3
}

struct ServerMainVCModel {

    let id: String
    let name: String
    let status: ServerCampainStatus
    let type: ServerCampainType
    let start: Date
    let end: Date

    init?(json: JSON) {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let status = ServerCampainStatus(rawValue: json["status"].intValue),
            let type = ServerCampainType(rawValue: json["type_id"].intValue),
            let start = dateFormatter.date(from: json["start"].stringValue),
            let end = dateFormatter.date(from: json["end"].stringValue)
            else { return nil }
        id = json["id"].stringValue
        name = json["name"].stringValue
        self.status = status
        self.type = type
        self.start = start
        self.end = end
    }
}
