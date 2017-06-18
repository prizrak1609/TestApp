//
//  ServerChartTests.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 12.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import XCTest
@testable import DisplayPlanStats

class ServerChartTests: XCTestCase {

    var server: ServerChart?
    
    override func setUp() {
        super.setUp()
        server = ServerChart()
        ServerBase.setBaseAddress("http://dev.displayplan.digital")
    }
    
    override func tearDown() {
        server = nil
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertTrue(true)
    }

    func testGetStatisticsLiftNLearnModel() {
        // TODO: send request getStatistic<ServerChartLiftNLearnModel>
    }
}
