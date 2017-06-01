//
//  BarChartDataEntry.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 30.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Charts

final class BarChartEntry : BarChartDataEntry {

    let label: String

    init(x: Double, y: Double, label: String) {
        self.label = label
        super.init(x: x, y: y)
    }

    required init() {
        fatalError("init() has not been implemented")
    }
}
