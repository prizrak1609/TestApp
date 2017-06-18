//
//  ServerLogin.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class ServerLogin : ServerBaseClass {

    func login(username: String, password: String, _ block: @escaping (ServerResult<ServerLoginModel>) -> Void) {
        guard let url = URL(string: "\(baseAddress)/api/support/signin") else {
            block(.error(NSError(domain: "can't create url from \(baseAddress)/api/support/signin", code: 0, userInfo: nil)))
            return
        }
        let params = ["username" : username,
                      "password" : password]
        let request = Alamofire.request(url, method: .post, parameters: params)
        request
            .responseString { d($0.result.value as Any) }
            .responseJSON(queue: .global(qos: .userInitiated)) { [weak self] response in
                guard let welf = self else { return }
                let result = welf.preParse(json: response)
                if case .result(let result) = result {
                    let model = ServerLoginModel(json: JSON(result))
                    DispatchQueue.main.async {
                        block(.result(model))
                    }
                } else if case .error(let error) = result {
                    DispatchQueue.main.async {
                        block(.error(error))
                    }
                }
            }
        requests["login"] = request
    }
}
