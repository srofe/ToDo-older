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
    var sutCoordinate: CLLocationCoordinate2D!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        sut.loadViewIfNeeded()

        sutCoordinate = CLLocationCoordinate2D(latitude: 27.4698, longitude: 153.0251)
        let location = Location(name: "Brisbane", coordinate: sutCoordinate)
        let item = ToDoItem(title: "Visit Southbank", description: "Do something fun!", timestamp: 1511923490, location: location)
        sutItemManager = ItemManager()
        sutItemManager.add(item: item)
        sut.itemInformation = (sutItemManager, 0)
    }

    override func tearDown() {
        sutCoordinate = nil
        sutItemManager.removeAllItems()
        sut = nil

        super.tearDown()
    }

    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel, "A DetailViewController shall have a title label.")
    }

    func testHasTimestampLabel() {
        XCTAssertNotNil(sut.dateLabel, "A DetailViewController shall have a date label.")
    }

    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel, "A DetailViewController shall have a location label.")
    }

    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel, "A DetailViewController shall have a description label.")
    }

    func testHasMapView() {
        XCTAssertNotNil(sut.mapView, "A DetailViewController shall have a map view.")
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

    func testSettingItemSetsDateLabel() {
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual("29/11/2017", sut.dateLabel.text, "A DetailViewController shall set the timestamp text when the item information is set.")
    }

    func testSettingItemSetsCoordinateLatitude() {
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sutCoordinate.latitude, sut.mapView.centerCoordinate.latitude, accuracy: 0.0001, "A DetailViewController shall set the latitude of the map view centre coordinate when the item information is set.")
    }

    func testSettingItemSetsCoordinateLongitude() {
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sutCoordinate.longitude, sut.mapView.centerCoordinate.longitude, accuracy: 0.0001, "A DetailViewController shall set the longitude of the map view centre coordinate when the item information is set.")
    }

    func testCheckButtonIsConnected() {
        XCTAssertNotNil(sut.checkButton, "A DetailViewController shall have an outlet for the check button.")
    }

    func testCheckButtonHasAction() {
        let button: UIButton = sut.checkButton
        let controlEvents = button.actions(forTarget: sut, forControlEvent: .touchUpInside)
        XCTAssertTrue((controlEvents?.contains("checkItem:")) ?? false, "A DetailViewController shall have an action for the check button.")
    }

    func testCheckItemUpdatesToDoAndDoneCounts() {
        sut.checkItem(sut.checkButton)
        XCTAssertEqual(0, sutItemManager.toDoCount, "A DetailViewController shall update the ToDo count when checkItem() is called.")
        XCTAssertEqual(1, sutItemManager.doneCount, "A DetailViewController shall update the Done count when checkItem() is called.")
    }

    func testCheckButtonHasCorrectName() {
        XCTAssertEqual("Check", sut.checkButton.titleLabel?.text, "A DetailViewController check button hsall have the name 'Check'.")
    }
}
