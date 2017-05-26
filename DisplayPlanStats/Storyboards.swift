//
//  Storyboards.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import UIKit

struct Storyboards {

    struct Name {
        static let main = "Main"
        static let login = "Login"
        static let settings = "Settings"
        static let charts = "Charts"
    }

    static let main = UIStoryboard(name: Name.main, bundle: nil).instantiateInitialViewController()
    static let login = UIStoryboard(name: Name.login, bundle: nil).instantiateInitialViewController()
    static let settins = UIStoryboard(name: Name.settings, bundle: nil).instantiateInitialViewController()
    static let charts = UIStoryboard(name: Name.charts, bundle: nil).instantiateInitialViewController()
}
