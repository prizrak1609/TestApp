//
//  ServerCampaign.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

final class ServerChart {

    func getStatistic<T: ServerChartProtocol>(id: String) -> Promise<T?> {
        guard let url = URL(string: "\(ServerBase.baseAddress)/api/statistics/campaign/\(id)") else {
            return Promise(error: NSError(domain: "can't convert \(ServerBase.baseAddress)/api/statistics/campaign/\(id) to URL", code: 0, userInfo: nil))
        }
        return Alamofire.request(url, method: .get).responseJSON(queue: .global(qos: .userInitiated)).then { return T(json: JSON($0)) }
    }
}
