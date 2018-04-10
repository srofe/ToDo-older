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
        sutMockURLSession = MockURLSession(data: nil, urlResoonse: nil, error: nil)
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

    func testLoginWhenSuccessfulCreatesToken() {
        let jsonData = "{\"token\":\"1234567890\"}".data(using: .utf8)
        sutMockURLSession = MockURLSession(data: jsonData, urlResoonse: nil, error: nil)
        sut.session = sutMockURLSession

        let tokenExpectation = expectation(description: "Token")
        var caughtToken: Token? = nil
        sut.loginUser(withName: "Foo", password: "Bar") { (token, _) in
            caughtToken = token
            tokenExpectation.fulfill()
        }

        waitForExpectations(timeout: 1) { (_) in
            XCTAssertEqual(caughtToken?.id, "1234567890", "An APIClient shall return a token for a valid login.")
        }
    }

    func testLoginWhenJSONIsInvalidReturnsError() {
        sutMockURLSession = MockURLSession(data: Data(), urlResoonse: nil, error: nil)
        sut.session = sutMockURLSession

        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.loginUser(withName: "Foo", password: "Bar") { (token, error) in
            catchedError = error
            errorExpectation.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError, "AN APIClient shall raise an exception when the JSON is invalid.")
        }
    }

    func testLoginWhenDataIsNilReturnsError() {
        sutMockURLSession = MockURLSession(data: nil, urlResoonse: nil, error: nil)
        sut.session = sutMockURLSession

        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.loginUser(withName: "Foo", password: "Bar") { (token, error) in
            catchedError = error
            errorExpectation.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError, "AN APIClient shall raise an exception when the data is nil.")
        }
    }
}

extension APIClientTests {

    class MockURLSession: SessionProtocol {

        var url: URL?
        private let dataTask: MockTask

        var urlComponents: URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }

        init(data: Data?, urlResoonse: URLResponse?, error: Error?) {
            dataTask = MockTask(data: data, urlResponse: urlResoonse, error: error)
        }

        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            print(url)
            dataTask.completionHandler = completionHandler

            return dataTask
        }
    }

    class MockTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?

        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?

        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }

        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data, self.urlResponse, self.responseError)
            }
        }
    }

}
