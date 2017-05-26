//
//  String+Ext.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation

extension String {

    func trimmed(_ characters: CharacterSet) -> String {
        return trimmingCharacters(in: characters)
    }

    var trimmed: String {
        return trimmed(.whitespaces)
    }

    var isBlank: Bool {
        return trimmed(.whitespacesAndNewlines).isEmpty
    }

    var isNotBlank: Bool {
        return !isBlank
    }
}
