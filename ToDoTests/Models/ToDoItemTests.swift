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
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInitSetsTitle() {
        let item = ToDoItem(title: "Item Title")
        XCTAssertEqual("Item Title", item.title, "A ToDo shall set it's title when initialised.")
    }

    func testInitSetsDescriptionIfProvidedInInitialiser() {
        let item = ToDoItem(title: "Item Title", description: "A description of the ToDo item")
        XCTAssertEqual("A description of the ToDo item", item.description, "A ToDo shall set it's description if it is provided in the initialiser.")
    }

}
