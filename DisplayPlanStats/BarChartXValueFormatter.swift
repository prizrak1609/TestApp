//
//  BarChartXValueFormatter.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 30.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Charts

final class BarChartXValueFormatter : NSObject, IAxisValueFormatter {

    var model: BarChartData?

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let model = model,
            let dataSet = model.getDataSetByIndex(0) as? BarChartDataSet,
            let entry = dataSet.entryForIndex(Int(value)) as? BarChartEntry
            else { return "" }
        return entry.label
    }
}
