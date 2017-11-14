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

    func testInitTakesTitle() {
        let item = ToDoItem(title: "Item Title")
    }

    func testInitTakesTitleAndDescription() {
        let item = ToDoItem(title: "Item Title", description: "A descriptino of the ToDo item")
    }

}
