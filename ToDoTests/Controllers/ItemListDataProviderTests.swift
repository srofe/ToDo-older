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

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNumberOfSectionsIsTwo() {
        let sut = ItemListDataProvider()
        let tableView = UITableView()
        tableView.dataSource = sut
        XCTAssertEqual(2, tableView.numberOfSections, "An ItemListDataProvider shall ensure the number of sections in the table view is 2.")
    }
}
