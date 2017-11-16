//
//  ItemListViewControllerTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 16/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTests: XCTestCase {

    // The System Under Test.
    var sut: ItemListViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        sut = viewController as! ItemListViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func testTableViewNotNilAfterLoading() {
        XCTAssertNotNil(sut.tableView, "An ItemListViewController shall have a table view after loading.")
    }

    func testLoadingViewSetsTableViewDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider, "An ItemListViewController shall set the table view data source to an ItemListDataProvider after loading.")
    }

    func testLoadingViewSetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider, "An ItemListViewController shall set the table view delegate to an ItemListDataProvider after loading.")
    }
}
