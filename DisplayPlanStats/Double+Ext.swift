//
//  Double+Ext.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 29.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation

public extension Double {

    public func roundedTo(places: Int) -> Double {
        precondition(places >= 0, "places must >= zero")
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
