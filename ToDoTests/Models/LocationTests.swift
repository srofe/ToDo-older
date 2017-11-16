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

    func testEqualLocationsAreEqual() {
        let firstLocation = Location(name: "Location Name")
        let secondLocation = Location(name: "Location Name")
        XCTAssertEqual(firstLocation, secondLocation, "A Location shall implement equatable.")
    }

    func testLocationsNotEqualWhenLatitutesAreNotEqual() {
        assertLocationNotEqualWith(firstName: "", firstLatlong: (0.0, 0.0), secondName: "", secondLatlong: (1.0, 0.0), "A Location shall not be equal to another location which has a different latitude.")
    }

    func testLocationsNotEqualWhenLongitudesAreNotEqual() {
        assertLocationNotEqualWith(firstName: "", firstLatlong: (0.0, 0.0), secondName: "", secondLatlong: (0.0, 1.0), "A Location shall not be equal to another location which has a different longitude.")
    }

    func testLocationsWhenOnlyOneHasACoordinateAreNotEqual() {
        assertLocationNotEqualWith(firstName: "", firstLatlong: (0.0, 0.0), secondName: "", secondLatlong: nil, "A Location, which has a coordinate, shall not be equal to another location which does not have a coordinate.")
    }

    func testLocationWhenNamesAreDifferentAreNoteEqual() {
        assertLocationNotEqualWith(firstName: "Location Name", firstLatlong: nil, secondName: "Different Name", secondLatlong: nil)
    }
}

extension XCTestCase {
    func assertLocationNotEqualWith(firstName: String, firstLatlong: (Double, Double)?,
                                    secondName: String, secondLatlong: (Double, Double)?, _ message: String = "", file: StaticString = #file, line: UInt = #line) {
        var firstCoordinate: CLLocationCoordinate2D? = nil
        var secondCoordinate: CLLocationCoordinate2D? = nil

        if let firstLatlong = firstLatlong {
            firstCoordinate = CLLocationCoordinate2D(latitude: firstLatlong.0, longitude: firstLatlong.1)
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoordinate)

        if let secondLatlong = secondLatlong {
            secondCoordinate = CLLocationCoordinate2D(latitude: secondLatlong.0, longitude: secondLatlong.1)
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoordinate)

        XCTAssertNotEqual(firstLocation, secondLocation, file: file, line: line)
    }
}
