//
//  LineChartXValueFormatter.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Charts

final class LineChartXValueFormatter : NSObject, IAxisValueFormatter {

    var model: LineChartData?

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let model = model,
            let dataSet = model.getDataSetByIndex(0) as? LineChartDataSet,
            let entry = dataSet.entryForIndex(Int(value)) as? LineChartDataEntry
            else { return "" }
        dateFormatter.dateFormat = "dd/MM/yy hh:mm"
        return dateFormatter.string(from: entry.date)
    }
}
