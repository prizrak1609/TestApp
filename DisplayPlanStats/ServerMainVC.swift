//
//  ServerMainVC.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

final class ServerMainVC {

    var campains: Promise<[ServerMainVCModel]> {
        guard let url = URL(string: "\(ServerBase.baseAddress)/api/statistics/data") else {
            return Promise(error: NSError(domain: "can't create url from \(ServerBase.baseAddress)/api/support/signin", code: 0, userInfo: nil))
        }
        return Alamofire.request(url, method: .get).responseJSON(queue: .global(qos: .userInitiated)).then { json -> [ServerMainVCModel] in
            let json = JSON(json)
            let result: [ServerMainVCModel]
            if json["success"].boolValue {
                let data = json["data"].arrayValue
                result = data.flatMap { ServerMainVCModel(json: $0) }
            } else {
                throw NSError(domain: "Somesing wrong", code: 0, userInfo: nil)
            }
            return result
        }
    }
}
