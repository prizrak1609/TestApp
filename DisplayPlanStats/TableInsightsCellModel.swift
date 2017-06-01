//
//  TableInsightsCellModel.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 30.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation

struct TableInsightsCellModel {

    let topLocation: String
    let dwellTime: Double
    let tableDatas: [ServerChartLiftNLearnModel.Insights.TableData]

    init(_ model: ServerChartLiftNLearnModel.Insights) {
        dwellTime = model.dwellTime
        topLocation = model.devices.max()?.location ?? ""
        tableDatas = model.tableDatas
    }
}
