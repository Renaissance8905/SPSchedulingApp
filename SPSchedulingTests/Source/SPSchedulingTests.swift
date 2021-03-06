//
//  SchedulingWidgetTests.swift
//  SchedulingWidgetTests
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import XCTest
@testable import SchedulingWidget

class SPSchedulingTests: XCTestCase {

    func testServiceResponse() {
        do {
            let bundle = Bundle.main
            XCTAssertNotNil(bundle)
            let path = bundle.path(forResource: "stubGetServices", ofType: "json")
            XCTAssertNotNil(path)
            
            let data = try Data(contentsOf: URL(fileURLWithPath: path!, isDirectory: false))
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(ServiceResponse.self, from: data)
            
            XCTAssertEqual(response.data.count, 7)
            XCTAssertEqual(response.data.first?.attributes.rate, "300.0")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testLocationResponse() {
        do {
            let bundle = Bundle.main
            XCTAssertNotNil(bundle)
            let path = bundle.path(forResource: "stubGetLocations", ofType: "json")
            XCTAssertNotNil(path)
            
            let data = try Data(contentsOf: URL(fileURLWithPath: path!, isDirectory: false))
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(LocationResponse.self, from: data)
            
            XCTAssertEqual(response.data.count, 3)
            XCTAssertEqual(response.data.first?.attributes.city, "Port Alyssonbury")
            XCTAssertEqual(response.data.first?.attributes.isVideo, false)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

}
