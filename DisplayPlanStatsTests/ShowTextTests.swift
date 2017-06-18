//
//  ShowTextTests.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 12.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import XCTest
@testable import DisplayPlanStats

class ShowTextTests: XCTestCase {

    func testExample() {
        XCTAssertTrue(true)
    }

    func testShowText() {
        let wait = expectation(description: "testShowText")
        wait.expectedFulfillmentCount = 6
        showText("Test text 0")
        showText("Test text 1", time: 2)
        showText("Tap on this text", time: 50, onTap: { wait.fulfill() })
        showText("Test text 2", time: 2, completionBlock: { wait.fulfill() })
        showText("Test text 3", time: 2, onTap: { wait.fulfill() }, completionBlock: { wait.fulfill() })
        showText("Tap on this text", onTap: { wait.fulfill() })
        showText("Test text 5", onTap: { wait.fulfill() }, completionBlock: { wait.fulfill() })
        showText("Test text 6", completionBlock: { wait.fulfill() })
        waitForExpectations(timeout: 100, handler: nil)
    }
}
