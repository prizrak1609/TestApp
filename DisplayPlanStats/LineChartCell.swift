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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    static var height: CGFloat = 310

    func initialise() {
        initLineChart()
    }
}

private extension LineChartCell {

    func initLineChart() {
        lineChart.legend.enabled = false
        lineChart.xAxis.labelRotationAngle = -45
        lineChart.xAxis.drawAxisLineEnabled = true
        lineChart.xAxis.drawGridLinesEnabled = true
        lineChart.xAxis.valueFormatter = LineChartXValueFormatter()
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.granularity = 1
        lineChart.xAxis.granularityEnabled = true
        lineChart.rightAxis.drawZeroLineEnabled = true
        lineChart.rightAxis.zeroLineWidth = 1
        lineChart.rightAxis.enabled = true
        lineChart.rightAxis.drawGridLinesEnabled = true
        lineChart.leftAxis.enabled = true
        lineChart.leftAxis.drawZeroLineEnabled = false
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.autoScaleMinMaxEnabled = true
        lineChart.noDataText = "No chart data available"
        lineChart.data = nil
        lineChart.chartDescription?.text = ""
        lineChart.delegate = self
    }
}

extension LineChartCell : ChartViewDelegate {

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("selected \(entry)")
    }
}
