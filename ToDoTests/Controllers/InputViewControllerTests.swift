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
}
