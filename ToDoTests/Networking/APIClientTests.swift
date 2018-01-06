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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoginUsesExpectedHost() {
        let sut = APIClient()
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "dasdom", password: "1234", completion: completion)
        guard let url = mockURLSession.url else { XCTFail(""); return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
    
        XCTAssertEqual(urlComponents?.host, "awsometodos.com")
    }

    func testLoginUsesExpectedPath() {
        let sut = APIClient()
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        let completion = { (token: Token?, error: Error?) in }
        sut.loginUser(withName: "dasdom", password: "1234", completion: completion)
        guard let url = mockURLSession.url else { XCTFail(""); return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)

        XCTAssertEqual(urlComponents?.path, "/login")
    }
}

class MockURLSession: SessionProtocol {

    var url: URL?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url

        return URLSession.shared.dataTask(with: url)
    }
}
