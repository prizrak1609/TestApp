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

    func getStatistic(id: String) {
        guard let url = URL(string: "\(ServerBase.baseAddress)/api/statistics/campaign/\(id)") else { return }
        Alamofire.request(url, method: .get).responseString().then { result -> Void in
            print(result)
        }.catch { print($0.localizedDescription) }
    }
}
