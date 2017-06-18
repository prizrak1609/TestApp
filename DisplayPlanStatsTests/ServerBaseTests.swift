//
//  ServerBaseTests.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 12.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import XCTest
@testable import DisplayPlanStats

class ServerBaseTests: XCTestCase {

    func testExample() {
        XCTAssertTrue(true)
    }

    func testSetBaseAddress() {
        ServerBase.setBaseAddress("http://dev.displayplan.digital")
        let startBaseAddress = ServerBase.baseAddress
        ServerBase.setBaseAddress("http://oralb.displayplan.digital")
        XCTAssertTrue(ServerBase.baseAddress != startBaseAddress, "base address: \(ServerBase.baseAddress)")
        XCTAssertTrue(ServerBase.baseAddress == "http://oralb.displayplan.digital", "base address: \(ServerBase.baseAddress)")
        let addressFromDefaults = UserDefaults.standard.string(forKey: UserDefaults.Server.baseAddress)
        XCTAssertTrue(addressFromDefaults != nil, "address from defaults is nil)")
        XCTAssertTrue(addressFromDefaults! == "http://oralb.displayplan.digital", "address from defaults: \(addressFromDefaults!)")
    }
}
