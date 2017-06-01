//
//  TableInsightsCellViewModel.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 30.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import UIKit

protocol TableInsightsCellViewModelDelegate : class {
    func reloadTableView()
}

final class TableInsightsCellViewModel : NSObject {

    weak var delegate: TableInsightsCellViewModelDelegate?

    var models: [ServerChartLiftNLearnModel.Insights.TableData] = [] {
        didSet {
            calculatedHeight = TableInsightsCellCell.height * CGFloat(models.count)
            delegate?.reloadTableView()
        }
    }

    var calculatedHeight: CGFloat = 0
}

extension TableInsightsCellViewModel : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableInsightsCellCell.self)) as? TableInsightsCellCell else { return UITableViewCell() }
        cell.model = models[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
