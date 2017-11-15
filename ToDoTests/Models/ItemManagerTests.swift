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

    func testAddItemIncreaseTodoCountByOne() {
        sut.add(item: ToDoItem(title: ""))
        XCTAssertEqual(1, sut.toDoCount, "An ItemManager shall increase the ToDo item count by one when an item is added.")
    }

    func testItemAtReturnsItemAdded() {
        sut.add(item: ToDoItem(title: "Item Name"))
        let item = sut.item(at: 0)
        XCTAssertEqual("Item Name", item.title, "An ItemManager shall enable an item added to be returned.")
    }

    func testCheckItemDecrementsToDoCount() {
        sut.add(item: ToDoItem(title: "Item Name"))
        sut.checkItem(at: 0)
        XCTAssertEqual(0, sut.toDoCount, "An ItemManager shall decrement the ToDo item count by one when an item is checked.")
    }

    func testCheckItemIncrementsDoneCount() {
        sut.add(item: ToDoItem(title: "Item Title"))
        sut.checkItem(at: 0)
        XCTAssertEqual(1, sut.doneCount, "An ItemManager shall increment the done count by one when an item is checked.")
    }
}
