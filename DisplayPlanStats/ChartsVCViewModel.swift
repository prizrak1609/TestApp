//
//  ChartsVCViewModel.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 26.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import PromiseKit
import Charts

protocol ChartsVCViewModelProtocol : class {
    func lineChartData(_ data: LineChartData?)
    func pieChartData(_ data: PieChartData?)
    func barChartData(_ data: BarChartData?)
    func tableInsigts(_ data: TableInsightsCellModel?)
    func error(_ error: Error)
}

final class ChartsVCViewModel {

    weak var delegate: ChartsVCViewModelProtocol?

    private let server = ServerChart()

    func getData(id: String, type: ServerCampainType) {
        if case .liftNLearn = type {
            server.getStatistic(id: id).then { [weak self] (model: ServerChartLiftNLearnModel?) -> Void in
                guard let delegate = self?.delegate, let model = model else { return }
                // MARK: processing line chart data
                let lineEntries = model.interactions.enumerated().map { index, entry in
                    return LineChartDataEntry(x: Double(index), y: Double(entry.count), date: entry.data)
                }
                let lineDataSet = LineChartDataSet(values: lineEntries, label: nil)
                lineDataSet.circleRadius = 3
                lineDataSet.drawValuesEnabled = false
                let lineData = LineChartData(dataSet: lineDataSet)
                DispatchQueue.main.async {
                    delegate.lineChartData(lineData)
                }
                // MARK: processing pie chart data
                let pieEntries = model.lifts.map { model in
                    return PieChartDataEntry(value: model.count, label: model.tag)
                }
                let pieDataSet = PieChartDataSet(values: pieEntries, label: nil)
                pieDataSet.colors = chartColors
                pieDataSet.drawIconsEnabled = false
                let pieData = PieChartData(dataSet: pieDataSet)
                DispatchQueue.main.async {
                    delegate.pieChartData(pieData)
                }
                // MARK: processing bar chart data
                let barEntries = model.lifts.enumerated().map { index, model in
                    return BarChartEntry(x: Double(index), y: model.count, label: model.tag)
                }
                let barDataSet = BarChartDataSet(values: barEntries, label: nil)
                barDataSet.colors = chartColors
                let barData = BarChartData(dataSet: barDataSet)
                DispatchQueue.main.async {
                    delegate.barChartData(barData)
                }
                // MARK: processing table insights data
                let tableInsightsModel = TableInsightsCellModel(model.insight)
                DispatchQueue.main.async {
                    delegate.tableInsigts(tableInsightsModel)
                }
            }.catch(execute: delegate?.error(_:) ?? { _ in })
        }
    }
}
