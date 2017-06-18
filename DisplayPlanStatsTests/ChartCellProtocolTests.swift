//
//  ChartCellProtocolTests.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 12.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import XCTest
@testable import DisplayPlanStats

class ChartCellProtocolTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertFalse(false)
    }

    func testLoadFromXib() {
        let view = LineChartCell.loadFromXib(owner: nil)
        XCTAssertNotNil(view)
    }
}
