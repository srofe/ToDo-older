//
//  InputViewControllerTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 2/12/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import XCTest
@testable import ToDo

class InputViewControllerTests: XCTestCase {

    // The System Under Test.
    var sut: InputViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        sut.loadViewIfNeeded()
        sut.itemManager = ItemManager()
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func testHasTitleTextField() {
        XCTAssertNotNil(sut.titleTextField, "An InputViewController shall have a title text field.")
    }

    func testHasDateTextField() {
        XCTAssertNotNil(sut.dateTextField, "An InputViewController shall have a date text field.")
    }

    func testHasLocationTextField() {
        XCTAssertNotNil(sut.locationTextField, "An InputViewController shall have a location text field.")
    }

    func testHasAddressTextField() {
        XCTAssertNotNil(sut.addressTextField, "An InputViewController shall have an address text field.")
    }

    func testHasDescriptionTextField() {
        XCTAssertNotNil(sut.descriptionTextField, "An InputViewController shall have a description text field.")
    }

    func testHasSaveButton() {
        XCTAssertNotNil(sut.saveButton, "An InputViewController shall have a save button.")
    }

    func testSaveButtonTextIsSave() {
        XCTAssertEqual(sut.saveButton.titleLabel?.text, "Save", "An InputViewController save button text shall be 'Save'.")
    }

    func testHasCancelBzutton() {
        XCTAssertNotNil(sut.cancelButton, "An InputViewController shall have a cancel button.")
    }

    func testCancelButtonTextIsCancel() {
        XCTAssertEqual(sut.cancelButton.titleLabel?.text, "Cancel", "An InputViewController cancel button text shall be 'Cancel'.")
    }

    func testSaveButtonHasAction() {
        let button = sut.saveButton
        let controlEvents = button?.actions(forTarget: sut, forControlEvent: .touchUpInside)
        XCTAssertTrue(controlEvents?.contains("saveItem:") ?? false, "An InputViewController shall have an action for the save button.")
    }

    func testCancelButtonHasAction() {
        let button = sut.cancelButton
        let controlEvents = button?.actions(forTarget: sut, forControlEvent: .touchUpInside)
        XCTAssertTrue(controlEvents?.contains("cancel:") ?? false, "An InputViewController shall have an action for the cancel button.")
    }

    func testSaveButtonAddsItemToItemManager() {
        sut.saveItem(sut.saveButton)
        XCTAssertEqual(1, sut.itemManager?.toDoCount, "An InputViewController shall update the ToDo count when saveItem() is called.")
    }

    func testSaveButtonSavesItemTitleToToDoItem() {
        sut.titleTextField.text = "New Item"
        sut.saveItem(sut.saveButton)
        let newItem = sut.itemManager?.item(at: 0)
        XCTAssertEqual("New Item", newItem?.title, "An InputViewController shall set the item title for a new item when the saveItem() is called.")
    }

    func testSaveButtonSavesItemDateToToDoItem() {
        // Note: 0:00 on 24 March 2017 in Brisbane is 14:00 on 23 March UTC
        // since Brisbane is 10 hours ahead.
        // 1970 - 2017 = 47 years (with 11 leap years).
        // No days = 47 * 365 + 11 + 31 (Jan) + 28 (Feb) + 23 (Mar) = 17248 days
        // No hours = 17248 * 24 + 14 (14:00 hours on 23) = 413966 hours
        // No seconds = 41266 * 60 * 60 = 1490277600 seconds
        sut.dateTextField.text = "24/03/2017"
        sut.saveItem(sut.saveButton)
        let newItem = sut.itemManager?.item(at: 0)
        XCTAssertEqual(1490277600.0, newItem?.timestamp, "An InputViewController shall set the item timestampe for a new item when saveItem() is called.")
    }

    func testSaveButtonSavesItemDescriptonToToDoItem() {
        sut.descriptionTextField.text = "Item description"
        sut.saveItem(sut.saveButton)
        let newItem = sut.itemManager?.item(at: 0)
        XCTAssertEqual("Item description", newItem?.description, "An InputViewController shall set the item description fro a new item when saveItem() is called.")
    }
}
