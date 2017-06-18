//
//  ServerLoginTests.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 12.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import XCTest
@testable import DisplayPlanStats

class ServerLoginTests : XCTestCase {

    var server: ServerLogin?

    override func setUp() {
        super.setUp()
        server = ServerLogin()
        ServerBase.setBaseAddress("http://dev.displayplan.digital")
    }

    override func tearDown() {
        server = nil
        super.tearDown()
    }

    func testExample() {
        XCTAssertTrue(true)
    }

    func testLoginBadParameters() {
        let testWait = expectation(description: "start wait server login")
        server!.login(username: "", password: "") { result -> Void in
            if case .result(let model) = result {
                XCTAssertFalse(model.success, "model.success: \(model.success)")
                testWait.fulfill()
            } else if case .error(let error) = result {
                print(error)
                testWait.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testLoginGoodParameters() {
        let testWait = expectation(description: "start wait server login")
        server!.login(username: "kevin", password: "displayplan") { result -> Void in
            if case .result(let model) = result {
                XCTAssertTrue(model.success, "model.success: \(model.success)")
                XCTAssertFalse(model.name.isEmpty, "model.name: \(model.name)")
                XCTAssertFalse(model.identifier.isEmpty, "model.identifier: \(model.identifier)")
                testWait.fulfill()
            } else if case .error(let error) = result {
                XCTAssertTrue(false, error.localizedDescription)
                testWait.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testBadUrl() {
        ServerBase.setBaseAddress("http://&^")
        let testWait = expectation(description: "start wait server login")
        server!.login(username: "kevin", password: "displayplan") { result -> Void in
            if case .error(let error) = result {
                print(error)
                XCTAssertFalse(error.localizedDescription.isEmpty, "error.localizedDescription: \(error.localizedDescription)")
                testWait.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
