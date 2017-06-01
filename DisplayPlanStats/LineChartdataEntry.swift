//
//  LineChartdataEntry.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 26.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Charts

final class LineChartDataEntry : ChartDataEntry {

    let date: Date

    init(x: Double, y: Double, date: Date) {
        self.date = date
        super.init(x: x, y: y)
    }

    required init() {
        fatalError("init() has not been implemented")
    }
}
