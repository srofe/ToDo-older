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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTodoCountInitiallySetToZero() {
        let sut = ItemManager()
        XCTAssertEqual(0, sut.toDoCount, "An ItemManger shall initialise the count of ToDo items to zero.")
    }
    
    func testDoneCountInitiallySetToZero() {
        let sut = ItemManager()
        XCTAssertEqual(0, sut.doneCount, "An ItemManager shall initialise the count of done items to zero.")
    }
}
