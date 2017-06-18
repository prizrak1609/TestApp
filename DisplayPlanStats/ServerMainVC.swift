//
//  ServerMainVC.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class ServerMainVC : ServerBaseClass {

    func campains(_ block: @escaping (ServerResult<[ServerMainVCModel]>) -> Void) {
        guard let url = URL(string: "\(baseAddress)/api/statistics/data") else {
            block(.error(NSError(domain: "can't create url from \(baseAddress)/api/support/signin", code: 0, userInfo: nil)))
            return
        }
        let request = Alamofire.request(url, method: .get)
        request.responseJSON(queue: .global(qos: .userInitiated)) { [weak self] response in
            guard let welf = self else { return }
            let result = welf.preParse(json: response)
            if case .result(let json) = result {
                let json = JSON(json)
                if json["success"].boolValue {
                    let data = json["data"].arrayValue
                    let result = data.flatMap { ServerMainVCModel(json: $0) }
                    DispatchQueue.main.async {
                        block(.result(result))
                    }
                } else {
                    DispatchQueue.main.async {
                        block(.error(NSError(domain: "Somesing wrong", code: 0, userInfo: nil)))
                    }
                }
            } else if case .error(let error) = result {
                DispatchQueue.main.async {
                    block(.error(error))
                }
            }
        }
        requests["campains"] = request
    }
}
