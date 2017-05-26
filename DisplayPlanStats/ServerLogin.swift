//
//  ServerLogin.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

final class ServerLogin {

    func login(username: String, password: String) -> Promise<ServerLoginModel> {
        guard let url = URL(string: "\(ServerBase.baseAddress)/api/support/signin") else {
            return Promise(error: NSError(domain: "can't create url from \(ServerBase.baseAddress)/api/support/signin", code: 0, userInfo: nil))
        }
        let params = ["username" : username,
                      "password" : password]
        return Alamofire.request(url, method: .post, parameters: params).responseString()
                        .then { json -> ServerLoginModel in
                            print(json)
                            return ServerLoginModel(json: JSON(json))
                        }
    }
}
