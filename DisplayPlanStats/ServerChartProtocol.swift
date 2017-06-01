//
//  ServerChartProtocol.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 26.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ServerChartProtocol {
    init?(json: JSON)
}
