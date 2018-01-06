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
        sut.loginUser(withName: "dasdom", password: "1234", completion: completion)
    }

    override func tearDown() {
        sutMockURLSession = nil
        sut = nil

        super.tearDown()
    }

    func testLoginUsesExpectedHost() {
        XCTAssertEqual(sutMockURLSession.urlComponents?.host, "awsometodos.com")
    }

    func testLoginUsesExpectedPath() {
        XCTAssertEqual(sutMockURLSession.urlComponents?.path, "/login")
    }
}

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
