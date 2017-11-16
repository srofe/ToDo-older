//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 15/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {

    // Test variables used in the TestCase
    let sutTitle = "Item Title"
    let sutDescription = "A description of the ToDo item"

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInitSetsTitle() {
        let item = ToDoItem(title: sutTitle)
        XCTAssertEqual(sutTitle, item.title, "A ToDo shall set it's title when initialised.")
    }

    func testInitSetsDescriptionIfProvidedInInitialiser() {
        let item = ToDoItem(title: sutTitle, description: sutDescription)
        XCTAssertEqual(sutDescription, item.description, "A ToDo shall set it's description if it is provided in the initialiser.")
    }

    func testInitSetsTimestampIfProvidedInInitialiser() {
        let item = ToDoItem(title: sutTitle, timestamp: 0.0)
        XCTAssertEqual(0.0, item.timestamp, "A ToDo shall set it's timestamp if it is provided in the initialiser.")
    }
    
    func testInitSetsLocationIfProvidedInInitialiser() {
        let location = Location(name: "Location Name")
        let item = ToDoItem(title: sutTitle, location: location)
        XCTAssertEqual("Location Name", item.location?.name, "A ToDo shall set it's location if it is provided in the initialiser.")
    }

    func testEqualItemsAreEquatable() {
        let firstItem = ToDoItem(title: sutTitle)
        let secondItem = ToDoItem(title: sutTitle)
        XCTAssertEqual(firstItem, secondItem, "A ToDo item shall implement equatable.")
    }

}
