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

    // Constants used in this test case class.
    let sutItem: ToDoItem = ToDoItem(title: "First Item")

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
        sut.add(item: sutItem)
        XCTAssertEqual(1, sut.toDoCount, "An ItemManager shall increase the ToDo item count by one when an item is added.")
    }

    func testItemAtReturnsItemAdded() {
        sut.add(item: sutItem)
        let item = sut.item(at: 0)
        XCTAssertEqual(sutItem, item, "An ItemManager shall enable an item added to be returned.")
    }

    func testCheckItemDecrementsToDoCount() {
        sut.add(item: sutItem)
        sut.checkItem(at: 0)
        XCTAssertEqual(0, sut.toDoCount, "An ItemManager shall decrement the ToDo item count by one when an item is checked.")
    }

    func testCheckItemIncrementsDoneCount() {
        sut.add(item: sutItem)
        sut.checkItem(at: 0)
        XCTAssertEqual(1, sut.doneCount, "An ItemManager shall increment the done count by one when an item is checked.")
    }

    func testCheckItemRemovesItFromTodoItems() {
        sut.add(item: sutItem)
        let secondItem = ToDoItem(title: "Second Item")
        sut.add(item: secondItem)
        sut.checkItem(at: 0)
        XCTAssertEqual(secondItem, sut.item(at: 0), "An ItemManager shall remove a checked item from the collection of ToDo items.")
    }

    func testDoneItemAtReturnsCheckedItem() {
        sut.add(item: sutItem)
        sut.checkItem(at: 0)
        let doneItem = sut.doneItem(at: 0)
        XCTAssertEqual(sutItem, doneItem, "An ItemManager shall enable done items to be returned.")
    }

    func testRemoveAllItemsResultsInZeroToDoCount() {
        sut.add(item: sutItem)
        sut.add(item: ToDoItem(title: "Another Item"))
        XCTAssertEqual(2, sut.toDoCount)
        sut.removeAllItems()
        XCTAssertEqual(0, sut.toDoCount, "An ItemManager shall have a ToDo item count of zero when all items have been removed.")
    }

    func testRemoveAllItemsResultsIntZeroDoneCount() {
        sut.add(item: sutItem)
        sut.add(item: ToDoItem(title: "Another Item"))
        sut.checkItem(at: 0)
        XCTAssertEqual(1, sut.doneCount)
        sut.removeAllItems()
        XCTAssertEqual(0, sut.doneCount, "An ItemManager shall have a Done count of zero when all items have been removed.")
    }
}
