//
//  String+ExtTests.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 12.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import XCTest
@testable import DisplayPlanStats

class String_ExtTests: XCTestCase {

    func testExample() {
        XCTAssertTrue(true)
    }

    func testIsBlank() {
        let string = " "
        XCTAssertTrue(string.isBlank)
        XCTAssertFalse(string.isEmpty)
    }
}
