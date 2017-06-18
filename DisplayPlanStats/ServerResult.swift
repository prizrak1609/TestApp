//
//  ServerResult.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 14.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation

enum ServerResult<T : Any> {
    case result(T)
    case error(Error)
}
