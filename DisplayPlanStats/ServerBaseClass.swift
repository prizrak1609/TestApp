//
//  ServerBaseClass.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 16.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Alamofire

class ServerBaseClass {

    var requests = [String: DataRequest]()

    var baseAddress: String {
        return ServerBase.baseAddress
    }

    func preParse(json: DataResponse<Any>) -> ServerResult<Any> {
        if let error = json.error {
            return .error(error)
        }
        if case .failure(let error) = json.result {
            return .error(error)
        }
        if case .success(let result) = json.result {
            return .result(result)
        }
        return .error(NSError(domain: "somesing wrong", code: 0, userInfo: nil))
    }

    deinit {
        requests.forEach { _, request in
            request.cancel()
        }
        requests.removeAll()
    }
}
