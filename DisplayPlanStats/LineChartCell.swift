//
//  LineChartCell.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit
import Charts

final class LineChartCell: UIView, ChartCellProtocol {

    @IBOutlet weak var lineChart: LineChartView!

    var height: CGFloat = 310

    fileprivate let valueFormatter = LineChartXValueFormatter()

    var model: LineChartData? {
        didSet {
            guard let model = model else { return }
            valueFormatter.model = model
            lineChart.leftAxis.axisMinimum = model.yMin
            lineChart.leftAxis.axisMaximum = model.yMax
            lineChart.rightAxis.axisMinimum = model.yMin
            lineChart.rightAxis.axisMaximum = model.yMax
            lineChart.data = model
        }
    }

    func initialise() {
        initLineChart()
    }
}

private extension LineChartCell {

    func initLineChart() {
        lineChart.legend.enabled = false
        lineChart.xAxis.labelRotationAngle = -70
        lineChart.xAxis.drawAxisLineEnabled = true
        lineChart.xAxis.drawGridLinesEnabled = true
        lineChart.xAxis.valueFormatter = valueFormatter
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.granularity = 1
        lineChart.xAxis.granularityEnabled = true
        lineChart.rightAxis.drawZeroLineEnabled = true
        lineChart.rightAxis.zeroLineWidth = 1
        lineChart.rightAxis.enabled = true
        lineChart.rightAxis.drawGridLinesEnabled = true
        lineChart.leftAxis.enabled = true
        lineChart.autoScaleMinMaxEnabled = true
        lineChart.noDataText = "No chart data available"
        lineChart.data = nil
        lineChart.chartDescription?.text = ""
        lineChart.marker = ChartMarkerView.viewFromXib()
    }
}
