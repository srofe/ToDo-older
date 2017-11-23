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
    var sutFirstItem: ToDoItem!
    var sutSecondItem: ToDoItem!

    override func setUp() {
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sutItemListViewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        sutItemListViewController.loadViewIfNeeded()
        sutTableView = sutItemListViewController.tableView
        sutTableView.dataSource = sut
        sutTableView.delegate = sut
        sutFirstItem = ToDoItem(title: "First Item")
        sutSecondItem = ToDoItem(title: "Second Item")

        super.setUp()
    }

    override func tearDown() {
        sut = nil
        sutTableView = nil
        sutFirstItem = nil
        sutSecondItem = nil

        super.tearDown()
    }

    func testNumberOfSectionsIsTwo() {
        XCTAssertEqual(2, sutTableView.numberOfSections, "An ItemListDataProvider shall ensure the number of sections in the table view is 2.")
    }

    func testNumbrerOfRowsInFirstSectionIsTodoCount() {
        sut.itemManager?.add(item: sutFirstItem)
        XCTAssertEqual(1, sutTableView.numberOfRows(inSection: 0))
        sut.itemManager?.add(item: sutSecondItem)
        sutTableView.reloadData()

        XCTAssertEqual(sut.itemManager?.toDoCount, sutTableView.numberOfRows(inSection: 0), "An ItemListDataProvider shall set the number of rows in the first section to the number of ToDo items.")
    }

    func testNumberOfRowsIntSecondSectionIsDoneCount() {
        sut.itemManager?.add(item: sutFirstItem)
        sut.itemManager?.add(item: sutSecondItem)
        sut.itemManager?.checkItem(at: 0)
        XCTAssertEqual(1, sutTableView.numberOfRows(inSection: 1))
        sut.itemManager?.checkItem(at: 0)
        sutTableView.reloadData()

        XCTAssertEqual(sut.itemManager?.doneCount, sutTableView.numberOfRows(inSection: 1), "An ItemListDataProvider shall set the number of rows in the second secton to the number of Done items.")
    }

    func testCellForRowReturnsItemCell() {
        sut.itemManager?.add(item: sutFirstItem)
        sutTableView.reloadData()
        let cell = sutTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ItemCell, "An ItemListDataProvider shall provide access to cells at a valid row and index.")
    }

    func testCellForRowDequeuesCellFromTableView() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        sut.itemManager?.add(item: sutFirstItem)
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellGotDequeued, "An ItemListDataProvider shall deque cells from the table view.")
    }

    func testCellForRowCallsConfigCell() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        sut.itemManager?.add(item: sutFirstItem)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        XCTAssertEqual(sutFirstItem, cell.cachedItem, "An ItemListDataProvider shall set the item for a cell when calling the cellforRowAt() method.")
    }

    func testCellForRowSection2CallsConfigCellWithDoneItem() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        sut.itemManager?.add(item: sutFirstItem)
        sut.itemManager?.add(item: sutSecondItem)
        sut.itemManager?.checkItem(at: 1)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        XCTAssertEqual(sutSecondItem, cell.cachedItem, "An ItemListDataProvider shall set the item for a cell with calling cellForRowAt() method for section 2.")
    }

    func testDeleteButtonInFirstSectionShowsTitleCheck() {
        let deleteButtonTitle = sutTableView.delegate?.tableView?(sutTableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual("Check", deleteButtonTitle, "An ItemListDataProvider shall set the title of the delete button to 'Check' when a ToDo item is swiped.")
    }

    func testDeleteButtonInSecondSectionShowsTitleUncheck() {
        let deleteButtonTitle = sutTableView.delegate?.tableView?(sutTableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual("Uncheck", deleteButtonTitle, "An ItemListDataProvider shall set the title of the delete button to 'Uncheck' when a Done item is swiped.")
    }

    func testCheckingAnItemCheksItInTheItemManager() {
        sut.itemManager?.add(item: sutFirstItem)
        sutTableView.dataSource?.tableView?(sutTableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(0, sut.itemManager?.toDoCount)
        XCTAssertEqual(1, sut.itemManager?.doneCount)
        XCTAssertEqual(0, sutTableView.numberOfRows(inSection: 0), "An ItemListDataProvider shall delete an item from the ToDo list when it has been checked (deleted).")
        XCTAssertEqual(1, sutTableView.numberOfRows(inSection: 1), "An ItemListDataProvider shall add an item to the Done list when it has been checked (deleted from the ToDo list).")
    }

    func testUncheckingAnItemUnchecksItInTheItemManager() {
        sut.itemManager?.add(item: sutFirstItem)
        sut.itemManager?.checkItem(at: 0)
        sutTableView.reloadData()
        sutTableView.dataSource?.tableView?(sutTableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(1, sut.itemManager?.toDoCount)
        XCTAssertEqual(0, sut.itemManager?.doneCount)
        XCTAssertEqual(1, sutTableView.numberOfRows(inSection: 0), "An ItemListDataProvider shall add an item to the ToDo list when it has been unchecked (deleted from the Done list).")
        XCTAssertEqual(0, sutTableView.numberOfRows(inSection: 1), "An ItemListDataProvider shall delete an item from the Done list when it has been unchecked (deleted).")
    }
}

extension ItemListDataProviderTests {

    class MockTableView: UITableView {
        var cellGotDequeued = false

        class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y:0, width: 320, height:480), style: .plain)
            mockTableView.dataSource = dataSource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")

            return mockTableView
        }

        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true

            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }

    class MockItemCell: ItemCell {
        var cachedItem: ToDoItem?

        override func configCell(with item: ToDoItem, checked: Bool = false) {
            cachedItem = item
        }
    }

}
