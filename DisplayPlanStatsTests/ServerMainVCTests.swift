//
//  ServerMainVCTests.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 12.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import XCTest
@testable import DisplayPlanStats

class ServerMainVCTests: XCTestCase {

    var server: ServerMainVC?
    
    override func setUp() {
        super.setUp()
        server = ServerMainVC()
        ServerBase.setBaseAddress("http://dev.displayplan.digital")
    }
    
    override func tearDown() {
        server = nil
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertTrue(true)
    }

    func testCampains() {
        let testWait = expectation(description: "start wait server login")
         _ = server!.campains { result -> Void in
            if case .result(let model) = result {
                XCTAssertTrue(!model.isEmpty, "model.isEmpty: \(model.isEmpty)")
                for item in model {
                    XCTAssertFalse(item.id.isEmpty, "item.id: \(item.id)")
                    XCTAssertFalse(item.name.isEmpty, "item.name: \(item.name)")
                    XCTAssertTrue(item.start < item.end, "item.start: \(item.start), item.end: \(item.end)")
                    XCTAssertNotNil(ServerCampainType(rawValue: item.type.rawValue))
                }
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
        server!.campains { result -> Void in
            if case .error(let error) = result {
                print(error)
                XCTAssertFalse(error.localizedDescription.isEmpty, "error.localizedDescription: \(error.localizedDescription)")
                testWait.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
