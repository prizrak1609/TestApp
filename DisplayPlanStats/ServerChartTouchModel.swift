//
//  ServerChartTouchModel.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ServerChartLiftNLearnModel {

    let interactions: [Interaction]
    let insight: Insights
    let lifts: [Lift]

    fileprivate var maps: [String : String] = [:]

    init?(json: JSON) {
        guard json["success"].boolValue else { return nil }
        let data = json["data"]
        for value in data["mappings"].arrayValue {
            let key = value["tag"].stringValue
            let val = value["value"].stringValue
            maps[key] = val
        }
        let overall = data["overall"]
        insight = Insights(json: overall["highlights"])
        interactions = overall["interaction"].arrayValue.flatMap(Interaction.init(json:))
        // strange but this code produce error: Variable 'self.lifts' captured by a closure before being initialized
//        lifts = overall["lifts"].arrayValue.flatMap { json -> Lift? in
//            guard let tag = maps[json["tag"].stringValue] else { return nil }
//            let count = json["count"].intValue
//            return Lift(tag: tag, count: count)
//        }
        var array = [Lift]()
        for item in overall["lifts"].arrayValue {
            guard let tag = maps[item["tag"].stringValue] else { continue }
            let count = item["count"].intValue
            array.append(Lift(tag: tag, count: count))
        }
        lifts = array
    }
}

extension ServerChartLiftNLearnModel {

    struct Interaction {

        let data: Date
        let count: Int

        init?(json: JSON) {
            guard let date = dateFormatter.date(from: json["log_date"].stringValue) else { return nil }
            data = date
            count = json["count"].intValue
        }
    }

    struct Insights {

        let dwellTime: Float
        let devices: [Device]

        init(json: JSON) {
            dwellTime = json["dwell_time"].floatValue
            devices = json["devices"].arrayValue.map { json -> Device in
                let count = json["count"].intValue
                let name = json["name"].stringValue
                let location = json["location"].stringValue
                return Device(count: count, name: name, location: location)
            }
        }

        // disable because next type need in the this struct 
        // swiftlint:disable:next nesting
        struct Device {
            let count: Int
            let name: String
            let location: String
        }
    }

    struct Lift {
        let tag: String
        let count: Int
    }
}
