//
//  Variables.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation

var dateFormatter: DateFormatter = {
    let dateFormat = DateFormatter()
    dateFormat.locale = Locale(identifier: "en_US_POSIX")
    dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormat
}()
