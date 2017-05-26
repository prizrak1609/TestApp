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
    static var height: CGFloat { get }
    func initialise()
}
