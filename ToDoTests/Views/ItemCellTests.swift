//
//  ItemCellTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 21/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemCellTests: XCTestCase {

    // The System Under Test.
    var sut: ItemCell!

    // Variables used in this test class.
    var sutTableView: UITableView!
    var sutDataSource: FakeDataSource!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        controller.loadViewIfNeeded()
        sutTableView = controller.tableView
        sutDataSource = FakeDataSource()
        sutTableView?.dataSource = sutDataSource
        sut = sutTableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell

        super.setUp()
    }

    override func tearDown() {
        sutDataSource = nil
        sutTableView = nil
        sut = nil

        super.tearDown()
    }

    func testHasNameLabel() {
        XCTAssertNotNil(sut.titleLabel, "An ItemCell shall have a title label.")
    }

    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel, "An ItemCell shall have a location label.")
    }

    func testHasDateLabel() {
        XCTAssertNotNil(sut.dateLabel, "An ItemCell shall have a date label.")
    }

    func testConfigCellSetsTitleLabel() {
        sut.configCell(with: ToDoItem(title: "First Item"))
        XCTAssertEqual("First Item", sut.titleLabel.text, "An ItemCell configCell() shall set the title label text.")
    }

    func testConfigCellSetsDateLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: "01/01/2017")
        let timestamp = date?.timeIntervalSince1970
        sut.configCell(with: ToDoItem(title: "First Item", timestamp: timestamp))
        print("Timestamp: \(timestamp!)")
        XCTAssertEqual("01/01/2017", sut.dateLabel.text, "An ItemCell configCell() shall set the date label if a date has been supplied.")
    }
}

extension ItemCellTests {

    class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }

}
