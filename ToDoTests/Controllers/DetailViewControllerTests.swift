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
        XCTAssertTrue(titleLableIsSubview, "A DetailViewController shall have a title label which is a sub-view of the view controller's view.")
    }

    func testHasTimestampLabel() {
        let timestampLabelIsSubview = sut.timestampLabel?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(timestampLabelIsSubview, "A DetailViewController shall have a timestamp label which is a sub-view of the view controller's view.")
    }

    func testHasLocationLabel() {
        let locationLabelIsSubview = sut.locationLabel?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(locationLabelIsSubview, "A DetailViewController shall have a location label which is a sub-view of the view controller's view.")
    }

    func testHasDescriptionLabel() {
        let descriptionLabelIsSubview = sut.locationLabel?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(descriptionLabelIsSubview, "A DetailViewController shall have a description label which is a sub-view of the view controller's view.")
    }

    func testHasMapView() {
        let mapViewIsSubview = sut.mapView?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(mapViewIsSubview, "A DetailViewController shall have a map view which is a sub-view of the view controller's view.")
    }
}
