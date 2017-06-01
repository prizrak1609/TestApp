//
//  CircularDiagramValueFormatter.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 29.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Charts

final class CircularDiagramValueFormatter : NSObject, IValueFormatter {

    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if value > 5 {
            return "\(value.roundedTo(places: 1))%"
        } else {
            return ""
        }
    }
}
