//
//  CircularDiagram.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit
import Charts

final class CircularDiagramCell : UIView, ChartCellProtocol {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var pieChartView: PieChartView!

    var height: CGFloat = 295

    var model: PieChartData? {
        didSet {
            guard let model = model else { return }
            model.setValueFormatter(CircularDiagramValueFormatter())
            pieChartView.data = model
        }
    }

    func initialise() {
        nameLabel.text = "LIFT N LEARN"
        initPieChart()
    }
}

// MARK: initialisations
private extension CircularDiagramCell {

    func initPieChart() {
        pieChartView.usePercentValuesEnabled = true
        pieChartView.holeRadiusPercent = 0.3
        pieChartView.legend.enabled = true
        pieChartView.legend.verticalAlignment = .bottom
        pieChartView.legend.horizontalAlignment = .center
        pieChartView.chartDescription?.text = ""
        pieChartView.noDataText = "No chart data available"
        pieChartView.data = nil
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.highlightPerTapEnabled = false
    }
}
