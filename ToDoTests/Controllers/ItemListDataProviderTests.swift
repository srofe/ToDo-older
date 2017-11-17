//
//  ItemListDataProviderTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 17/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {

    // The System Under Test.
    var sut: ItemListDataProvider!

    // Variables used in this test class.
    var sutTableView: UITableView!

    override func setUp() {
        sut = ItemListDataProvider()
        sutTableView = UITableView()
        sutTableView.dataSource = sut

        super.setUp()
    }

    override func tearDown() {
        sut = nil
        sutTableView = nil

        super.tearDown()
    }

    func testNumberOfSectionsIsTwo() {
        XCTAssertEqual(2, sutTableView.numberOfSections, "An ItemListDataProvider shall ensure the number of sections in the table view is 2.")
    }

    func testNumbrerOfRowsInFirstSectionIsTodoCount() {
        sut.itemManager = ItemManager()
        sut.itemManager?.add(item: ToDoItem(title: "First Item"))
        XCTAssertEqual(1, sutTableView.numberOfRows(inSection: 0))
        sut.itemManager?.add(item: ToDoItem(title: "Second Item"))
        sutTableView.reloadData()

        XCTAssertEqual(sut.itemManager?.toDoCount, sutTableView.numberOfRows(inSection: 0), "An ItemListDataProvider shall set the number of rows in the first section to the number of ToDo items.")
    }

    func testNumberOfRowsIntSecondSectionIsDoneCount() {
        sut.itemManager = ItemManager()
        sut.itemManager?.add(item: ToDoItem(title: "First Item"))
        sut.itemManager?.add(item: ToDoItem(title: "Second Item"))
        sut.itemManager?.checkItem(at: 0)
        XCTAssertEqual(1, sutTableView.numberOfRows(inSection: 1))
        sut.itemManager?.checkItem(at: 0)
        sutTableView.reloadData()

        XCTAssertEqual(sut.itemManager?.doneCount, sutTableView.numberOfRows(inSection: 1), "An ItemListDataProvider shall set the number of rows in the second secton to the number of Done items.")
    }
}
