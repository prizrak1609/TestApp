//
//  ServerChartTouchModel.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ServerChartLiftNLearnModel : ServerChartProtocol {

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
            let count = item["count"].doubleValue
            array.append(Lift(originTag: item["tag"].stringValue, tag: tag, count: count))
        }
        lifts = array
        insight = Insights(json: overall["highlights"], maps: maps, lifts: lifts)
    }
}

extension ServerChartLiftNLearnModel {

    struct Interaction {

        let data: Date
        let count: Int

        init?(json: JSON) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            guard let date = dateFormatter.date(from: json["log_date"].stringValue) else { return nil }
            data = date
            count = json["count"].intValue
        }
    }

    struct Insights {

        let dwellTime: Double
        let devices: [Device]
        let tableDatas: [TableData]

        init(json: JSON, maps: [String : String], lifts: [ServerChartLiftNLearnModel.Lift]) {
            tableDatas = lifts.map { TableData(name: $0.tag, tag: $0.originTag, count: $0.count) }
            dwellTime = json["dwell_time"].doubleValue
            devices = json["devices"].arrayValue.map { json -> Device in
                let count = json["count"].intValue
                let name = json["name"].stringValue
                let location = json["location"].stringValue
                return Device(count: count, name: name, location: location)
            }
        }

        // disable because next type need in the this struct
        // swiftlint:disable:next nesting
        struct TableData {
            let name: String
            let tag: String
            let count: Double
        }

        // disable because next type need in the this struct 
        // swiftlint:disable:next nesting
        struct Device : Equatable, Comparable {
            let count: Int
            let name: String
            let location: String

            static func == (lhs: Device, rhs: Device) -> Bool {
                return lhs.count == rhs.count
            }

            static func < (lhs: Device, rhs: Device) -> Bool {
                return lhs.count < rhs.count
            }

            static func <= (lhs: Device, rhs: Device) -> Bool {
                return lhs.count <= rhs.count
            }

            static func >= (lhs: Device, rhs: Device) -> Bool {
                return lhs.count >= rhs.count
            }

            static func > (lhs: Device, rhs: Device) -> Bool {
                return lhs.count > rhs.count
            }
        }
    }

    struct Lift {
        fileprivate let originTag: String
        let tag: String
        let count: Double
    }
}
