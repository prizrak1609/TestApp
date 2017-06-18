//
//  UITableView+Ext.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit

extension UITableView {

    func register(nib: String, with bundle: Bundle? = nil) {
        register(UINib(nibName: nib, bundle: bundle), forCellReuseIdentifier: nib)
    }
}
