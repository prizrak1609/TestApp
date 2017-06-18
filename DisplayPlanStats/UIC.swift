//
//  UIC.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 23.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import UIKit

struct UIC {
    // device index
    static let index: Int = {
        let screen = UIScreen.main.bounds
        if UIApplication.shared.statusBarOrientation.isLandscape {
            switch screen.size {
            // iPhone 5, 5s
            case let size where size.width == 568:
                return 1
            // iPhone 6
            case let size where size.height == 375:
                return 2
            // iPhone 6+
            case let size where size.height == 414:
                return 3
            // iPads
            case let size where size.height >= 768:
                return 4
            // iPhone 4, 4s and below
            default:
                return 0
            }
        } else {
            switch screen.size {
            // iPhone 5, 5s
            case let size where size.height == 568:
                return 1
            // iPhone 6
            case let size where size.width == 375:
                return 2
            // iPhone 6+
            case let size where size.width == 414:
                return 3
            // iPads
            case let size where size.width >= 768:
                return 4
            // iPhone 4, 4s and below
            default:
                return 0
            }
        }
    }()

    // LaunchScreen.storyboard 
//    static let title = { return [20.0, 20.0, 21.0, 24.0, 30.0][index] }()
}
