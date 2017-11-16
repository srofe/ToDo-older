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

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTableViewNotNilAfterLoading() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        let sut = viewController as! ItemListViewController
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView, "An ItemListViewController shall have a table view after loading.")
    }

    func testLoadingViewSetsTableViewDataSource() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        let sut = viewController as! ItemListViewController
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider, "An ItemListViewController shall set the table view data source to an ItemListDataProvider after loading.")
    }
}
