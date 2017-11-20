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
    var sutItemListViewController: ItemListViewController!

    override func setUp() {
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sutItemListViewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        sutItemListViewController.loadViewIfNeeded()
        sutTableView = sutItemListViewController.tableView
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
        sut.itemManager?.add(item: ToDoItem(title: "First Item"))
        XCTAssertEqual(1, sutTableView.numberOfRows(inSection: 0))
        sut.itemManager?.add(item: ToDoItem(title: "Second Item"))
        sutTableView.reloadData()

        XCTAssertEqual(sut.itemManager?.toDoCount, sutTableView.numberOfRows(inSection: 0), "An ItemListDataProvider shall set the number of rows in the first section to the number of ToDo items.")
    }

    func testNumberOfRowsIntSecondSectionIsDoneCount() {
        sut.itemManager?.add(item: ToDoItem(title: "First Item"))
        sut.itemManager?.add(item: ToDoItem(title: "Second Item"))
        sut.itemManager?.checkItem(at: 0)
        XCTAssertEqual(1, sutTableView.numberOfRows(inSection: 1))
        sut.itemManager?.checkItem(at: 0)
        sutTableView.reloadData()

        XCTAssertEqual(sut.itemManager?.doneCount, sutTableView.numberOfRows(inSection: 1), "An ItemListDataProvider shall set the number of rows in the second secton to the number of Done items.")
    }

    func testCellForRowReturnsItemCell() {
        sut.itemManager?.add(item: ToDoItem(title: "First Item"))
        sutTableView.reloadData()
        let cell = sutTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ItemCell, "An ItemListDataProvider shall provide access to cells at a valid row and index.")
    }

    func testCellForRowDequeuesCellFromTableView() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        sut.itemManager?.add(item: ToDoItem(title: "First Item"))
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellGotDequeued, "An ItemListDatProvider shall deque cells from the table view.")
    }

    func testCellForRowCallsConfigCell() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
        let item = ToDoItem(title: "First Item")
        sut.itemManager?.add(item: item)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        XCTAssertEqual(item, cell.cachedItem, "An ItemManager shall set the item for a cell when callint the cellforRowAt() method.")
    }
}

extension ItemListDataProviderTests {

    class MockTableView: UITableView {
        var cellGotDequeued = false

        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true

            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }

    class MockItemCell: ItemCell {
        var cachedItem: ToDoItem?

        override func configCell(with item: ToDoItem) {
            cachedItem = item
        }
    }

}
