//
//  TableInsightsCellCell.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 30.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit

final class TableInsightsCellCell: UITableViewCell {

    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var mappingLabel: UILabel!
    @IBOutlet fileprivate weak var valueLabel: UILabel!

    static let height: CGFloat = 44

    var model: ServerChartLiftNLearnModel.Insights.TableData? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.name
            mappingLabel.text = model.tag
            valueLabel.text = "\(Int(model.count))"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        mappingLabel.text = ""
        valueLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
}
