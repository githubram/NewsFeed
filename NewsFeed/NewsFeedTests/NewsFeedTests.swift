//
//  NewsFeedTests.swift
//  NewsFeedTests
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import XCTest
@testable import NewsFeed

class NewsFeedTests: XCTestCase {
    var networkManager:NetworkManager!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkManager = NetworkManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkManager = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test whether API responses in quick time (timeout is 5 seconds)
    func testAPICallDuration()
    {
        // 1. Create Promise
        let promise = expectation(description: "Status code: 200")
        
        networkManager.getPopularNews { (newsArray, error) in
            if let apiError = error as? Error
            {
                XCTFail("Error: \(apiError.localizedDescription)")
                return
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
