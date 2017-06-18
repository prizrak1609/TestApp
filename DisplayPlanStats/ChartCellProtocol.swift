//
//  ChartCellProtocol.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import CoreGraphics

protocol ChartCellProtocol {
    var height: CGFloat { get }
    func initialise()
}

extension ChartCellProtocol {

    static func loadFromXib(owner: Any?, options: [AnyHashable : Any]?) -> Self? {
        let xib = Bundle.main.loadNibNamed(String(describing: self), owner: owner, options: options)?.first as? Self
        xib?.initialise()
        return xib
    }
}
