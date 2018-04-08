//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by Simon Rofe on 6/1/18.
//  Copyright © 2018 Simon Rofe. All rights reserved.
//

import XCTest
@testable import ToDo

class APIClientTests: XCTestCase {
    // The System Under Test.
    var sut: APIClient!

    // Variables used in this test class.
    var sutMockURLSession: MockURLSession!

    override func setUp() {
        super.setUp()

        sut = APIClient()
        sutMockURLSession = MockURLSession()
        sut.session = sutMockURLSession
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "dasdöm", password: "%&34", completion: completion)
    }

    override func tearDown() {
        sutMockURLSession = nil
        sut = nil

        super.tearDown()
    }

    func testLoginUsesExpectedHost() {
        XCTAssertEqual(sutMockURLSession.urlComponents?.host, "awsometodos.com", "An API Client shall have the correct host name for a URL login query.")
    }

    func testLoginUsesExpectedPath() {
        XCTAssertEqual(sutMockURLSession.urlComponents?.path, "/login", "An APIClient shall have the correct path for a URL login query.")
    }

    func testLoginContainsUserNameQuery() {
        let usernameQuery = URLQueryItem(name: "username", value: "dasdöm")

        if let queryItems = sutMockURLSession.urlComponents?.queryItems {
            XCTAssertTrue(queryItems.contains(usernameQuery), "An APIClient shall encode the username for a URL login query.")
        } else {
            XCTFail("The APIClient did no contain any query items.")
        }
    }

    func testLoginContainsPasswordQuery() {
        let passwordQuery = URLQueryItem(name: "password", value: "%&34")

        if let queryItems = sutMockURLSession.urlComponents?.queryItems {
            XCTAssertTrue(queryItems.contains(passwordQuery), "An APIClient shall encode the password for a URL login query.")
        } else {
            XCTFail("The APIClient did no contain any query items.")
        }
    }

    func testLoginUsesExpectedQuenry() {
        XCTAssertEqual(sutMockURLSession.urlComponents?.percentEncodedQuery, "username=dasd%C3%B6m&password=%25%2634", "An APIClient shall encode the username and password for a URL login query.")
    }
}

extension APIClientTests {

    class MockURLSession: SessionProtocol {

        var url: URL?

        var urlComponents: URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }

        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url

            return URLSession.shared.dataTask(with: url)
        }
    }

}
