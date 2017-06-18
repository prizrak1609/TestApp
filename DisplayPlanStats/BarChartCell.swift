//
//  BarChart.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit
import Charts

final class BarChartCell : UIView, ChartCellProtocol {

    @IBOutlet fileprivate weak var barChartView: BarChartView!

    var height: CGFloat = 295

    fileprivate let valueFormatter = BarChartXValueFormatter()

    var model: BarChartData? {
        didSet {
            guard let model = model else { return }
            valueFormatter.model = model
            barChartView.data = model
        }
    }

    func initialise() {
        initBarChart()
    }
}

private extension BarChartCell {

    func initBarChart() {
        barChartView.legend.enabled = false
        barChartView.xAxis.labelRotationAngle = -70
        barChartView.xAxis.drawAxisLineEnabled = true
        barChartView.xAxis.drawGridLinesEnabled = true
        barChartView.xAxis.valueFormatter = valueFormatter
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.granularityEnabled = true
        barChartView.rightAxis.drawZeroLineEnabled = true
        barChartView.rightAxis.zeroLineWidth = 1
        barChartView.rightAxis.enabled = true
        barChartView.rightAxis.drawGridLinesEnabled = true
        barChartView.leftAxis.enabled = true
        barChartView.autoScaleMinMaxEnabled = true
        barChartView.noDataText = "No chart data available"
        barChartView.data = nil
        barChartView.highlightPerTapEnabled = false
        barChartView.chartDescription?.text = ""
    }
}
