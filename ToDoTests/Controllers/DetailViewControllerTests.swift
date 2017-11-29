//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 29/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class DetailViewControllerTests: XCTestCase {

    // The System Under Test.
    var sut: DetailViewController!

    // Variables used in this test class.
    var sutItemManager: ItemManager!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        sut.loadViewIfNeeded()

        let coordinate = CLLocationCoordinate2D(latitude: 27.4698, longitude: 153.0251)
        let location = Location(name: "Brisbane", coordinate: coordinate)
        let item = ToDoItem(title: "Visit Southbank", description: "Do something fun!", timestamp: 1511923490, location: location)
        sutItemManager = ItemManager()
        sutItemManager.add(item: item)
        sut.itemInformation = (sutItemManager, 0)
    }

    override func tearDown() {
        sutItemManager.removeAllItems()
        sut = nil

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

    func testSettingItemSetsTitleLabel() {
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual("Visit Southbank", sut.titleLabel.text, "A DetailViewControll shall set the title text when the item information is set.")
    }

    func testSettingItemSetsLocationLabel() {
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual("Brisbane", sut.locationLabel.text, "A DetailViewController shall set the location text when the item information is set.")
    }

    func testSettingItemSetsDescriptionLabel() {
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual("Do something fun!", sut.descriptionLabel.text, "A DetailViewController shall set the description text when the item information is set.")
    }

    func testSettingItemSetsTimestampLabel() {
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual("29/11/2017", sut.timestampLabel.text, "A DetailViewController shall set the timestamp text when the item information is set.")
    }
}
