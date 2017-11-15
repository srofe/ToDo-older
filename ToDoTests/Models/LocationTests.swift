//
//  LocationTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 15/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class LocationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInitSetsName() {
        let location = Location(name: "Location Name")
        XCTAssertEqual("Location Name", location.name, "A Location shall set it's name when initialised.")
    }

    func testInitSetsCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Location Name", coordinate: coordinate)
        XCTAssertEqual(coordinate.latitude, location.coordinate?.latitude, "A Location shall set the coordinate's latitue when initialised.")
        XCTAssertEqual(coordinate.longitude, location.coordinate?.longitude, "A Location shall set the coordinate's longitude when initialised.")

    }

}
