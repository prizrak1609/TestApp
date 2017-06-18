//
//  ServerCampaign.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class ServerChart : ServerBaseClass {

    func getStatistic<T: ServerChartProtocol>(id: String, _ block: @escaping (ServerResult<T?>) -> Void) {
        guard let url = URL(string: "\(baseAddress)/api/statistics/campaign/\(id)") else {
            block(.error(NSError(domain: "can't convert \(baseAddress)/api/statistics/campaign/\(id) to URL", code: 0, userInfo: nil)))
            return
        }
        let request = Alamofire.request(url, method: .get)
        request.responseJSON(queue: .global(qos: .userInitiated)) { [weak self] response in
            guard let welf = self else { return }
            let result = welf.preParse(json: response)
            if case .result(let json) = result {
                let model = T(json: JSON(json))
                DispatchQueue.main.async {
                    block(.result(model))
                }
            } else if case .error(let error) = result {
                DispatchQueue.main.async {
                    block(.error(error))
                }
            }
        }
        requests["getStatistic\(String(describing: T.self))"] = request
    }
}
