//
//  TableInsightsCell.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit

final class TableInsightsCell: UIView, ChartCellProtocol {

    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var averageDwellTimeLabel: UILabel!
    @IBOutlet fileprivate weak var averageDwellTimeValueLabel: UILabel!
    @IBOutlet fileprivate weak var topLocationLabel: UILabel!
    @IBOutlet fileprivate weak var topLocationValueLabel: UILabel!
    @IBOutlet fileprivate weak var tableView: UITableView!

    fileprivate let viewModel = TableInsightsCellViewModel()

    var height: CGFloat = 200

    var model: TableInsightsCellModel? {
        didSet {
            guard let model = model else { return }
            averageDwellTimeValueLabel.text = "\(model.dwellTime.roundedTo(places: 2)) seconds"
            topLocationValueLabel.text = model.topLocation
            viewModel.models = model.tableDatas
            height = tableView.frame.origin.y + viewModel.calculatedHeight
        }
    }

    func initialise() {
        viewModel.delegate = self
        initLabels()
        initTableView()
    }
}

private extension TableInsightsCell {

    func initLabels() {
        nameLabel.text = "INSIGHTS"
        averageDwellTimeLabel.text = "Average Dwell Time:"
        topLocationLabel.text = "Top Location:"
    }

    func initTableView() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.rowHeight = TableInsightsCellCell.height
        tableView.register(nib: String(describing: TableInsightsCellCell.self))
    }
}

extension TableInsightsCell : TableInsightsCellViewModelDelegate {

    func reloadTableView() {
        tableView.reloadData()
    }
}
