//
//  ChartMarkerView.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 26.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import Charts

final class ChartMarkerView : MarkerView {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var dateValueLabel: UILabel!
    @IBOutlet private weak var entriesLabel: UILabel!
    @IBOutlet private weak var entriesValueLabel: UILabel!

    override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        var offset = CGPoint.zero
        let size = frame.size
        let screenSize = UIScreen.main.bounds
        if point.x + size.width > screenSize.width {
            offset.x = screenSize.width - point.x - size.width
        }
        return offset
    }

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        guard let entry = entry as? LineChartDataEntry else { return }
        dateFormatter.dateFormat = "dd/MM/yy hh:mm"
        dateValueLabel.text = dateFormatter.string(from: entry.date)
        entriesValueLabel.text = "\(entry.y)"
        layoutIfNeeded()
    }
}
