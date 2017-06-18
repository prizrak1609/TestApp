//
//  MainVCCell.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit

final class MainVCCell: UITableViewCell {

    @IBOutlet private weak var campainImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var startLabel: UILabel!
    @IBOutlet private weak var endLabel: UILabel!
    @IBOutlet private weak var background: UIView!

    static let height: CGFloat = 160

    var model: ServerMainVCModel? = nil {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.name
            let dateFormater = DateFormatter()
            dateFormater.locale = Locale(identifier: "en_US_POSIX")
            dateFormater.dateFormat = "yyyy/MM/dd HH:mm:ss"
            startLabel.text = "start: \(dateFormater.string(from: model.start))"
            endLabel.text = "end: \(dateFormater.string(from: model.end))"
            let status: String
            switch model.status {
                case .cancelled: status = "Cancelled"
                case .published: status = "Published"
                case .unpublished: status = "Unpublished"
            }
            statusLabel.text = status
            let image: UIImage
            switch model.type {
                case .liftNLearn: image = #imageLiteral(resourceName: "liftnlearn")
                case .touch: image = #imageLiteral(resourceName: "touch")
                case .video: image = #imageLiteral(resourceName: "video")
            }
            campainImageView.image = image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.shadowColor = UIColor.black.cgColor
        background.layer.shadowOpacity = 0.3
        background.layer.shadowOffset = CGSize(width: 0, height: 0)
        background.layer.shadowRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
}
