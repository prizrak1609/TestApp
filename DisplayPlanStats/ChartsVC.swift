//
//  ChartsVC.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit

final class ChartsVC: UIViewController {

    var campainID = ""
    var campainType = ServerCampainType.touch

    fileprivate let server = ServerChart()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(campainType)
        server.getStatistic(id: campainID)
    }
}
