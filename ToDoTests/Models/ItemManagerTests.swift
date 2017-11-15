//
//  ItemManagerTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 15/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {

    // The System Under Test.
    var sut: ItemManager!

    override func setUp() {
        super.setUp()

        sut = ItemManager()
    }

    override func tearDown() {
        sut = nil;

        super.tearDown()
    }

    func testTodoCountInitiallySetToZero() {
        XCTAssertEqual(0, sut.toDoCount, "An ItemManger shall initialise the count of ToDo items to zero.")
    }

    func testDoneCountInitiallySetToZero() {
        XCTAssertEqual(0, sut.doneCount, "An ItemManager shall initialise the count of done items to zero.")
    }
}
