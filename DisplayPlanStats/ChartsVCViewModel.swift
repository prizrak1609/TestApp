//
//  ChartsVCViewModel.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 26.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
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

    fileprivate let server = ServerChart()

    func getData(id: String, type: ServerCampainType) {
        switch type {
            case .liftNLearn: getLiftNLearnStatistic(id: id)
            case .touch: getTouchStatistic(id: id)
            case .video: getVideoStatistic(id: id)
        }
    }
}

private extension ChartsVCViewModel {

    func getVideoStatistic(id: String) {
        server.getStatistic(id: id) { [weak self] (result: ServerResult<ServerChartVideoModel?>) -> Void in
            guard let delegate = self?.delegate else { return }
            if case .result(let model) = result, model != nil {
                v(model as Any)
            } else if case .error(let error) = result {
                delegate.error(error)
            }
        }
    }

    func getTouchStatistic(id: String) {
        server.getStatistic(id: id) { [weak self] (result: ServerResult<ServerChartTouchModel?>) -> Void in
            guard let delegate = self?.delegate else { return }
            if case .result(let model) = result, model != nil {
                v(model as Any)
            } else if case .error(let error) = result {
                delegate.error(error)
            }
        }
    }

    func getLiftNLearnStatistic(id: String) {
        server.getStatistic(id: id) { [weak self] (result: ServerResult<ServerChartLiftNLearnModel?>) -> Void in
            guard let delegate = self?.delegate else { return }
            if case .result(let model) = result, model != nil {
                // disable because in if check model != nil
                // swiftlint:disable:next force_unwrapping
                let model = model!
                // MARK: processing line chart data
                let lineEntries = model.interactions.enumerated().map { index, entry in LineChartDataEntry(x: Double(index), y: Double(entry.count), date: entry.data) }
                let lineDataSet = LineChartDataSet(values: lineEntries, label: nil)
                lineDataSet.circleRadius = 3
                lineDataSet.drawValuesEnabled = false
                let lineData = LineChartData(dataSet: lineDataSet)
                DispatchQueue.main.async {
                    delegate.lineChartData(lineData)
                }
                // MARK: processing pie chart data
                let pieEntries = model.lifts.map { PieChartDataEntry(value: $0.count, label: $0.tag) }
                let pieDataSet = PieChartDataSet(values: pieEntries, label: nil)
                pieDataSet.colors = Charts.colors
                pieDataSet.drawIconsEnabled = false
                let pieData = PieChartData(dataSet: pieDataSet)
                DispatchQueue.main.async {
                    delegate.pieChartData(pieData)
                }
                // MARK: processing bar chart data
                let barEntries = model.lifts.enumerated().map { index, model in BarChartEntry(x: Double(index), y: model.count, label: model.tag) }
                let barDataSet = BarChartDataSet(values: barEntries, label: nil)
                barDataSet.colors = Charts.colors
                let barData = BarChartData(dataSet: barDataSet)
                DispatchQueue.main.async {
                    delegate.barChartData(barData)
                }
                // MARK: processing table insights data
                let tableInsightsModel = TableInsightsCellModel(model.insight)
                DispatchQueue.main.async {
                    delegate.tableInsigts(tableInsightsModel)
                }
            } else if case .error(let error) = result {
                delegate.error(error)
            }
        }
    }
}
