//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 29/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import XCTest
@testable import ToDo

class DetailViewControllerTests: XCTestCase {

    // The System Under Test.
    var sut: DetailViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHasTitleLabel() {
        let titleLableIsSubview = sut.titleLabel?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(titleLableIsSubview, "A DetailViewController shall have a title lable which is a sub-view of the view controller.")
    }
}
