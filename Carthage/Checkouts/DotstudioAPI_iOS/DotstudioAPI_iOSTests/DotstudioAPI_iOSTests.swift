//
//  DotstudioAPI_iOSTests.swift
//  DotstudioAPI_iOSTests
//
//  Created by Ketan Sakariya on 16/01/18.
//

import XCTest
@testable import DotstudioAPI_iOS

class DotstudioAPI_iOSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        SPLTRouter.API_KEY = "176908bf2a39eef53edf72b60e99e339da45a9ca"
        SPLTTokenAPI().getToken { (accessToken) in
            print("access token")
            print(accessToken)
        }
        //wait(for: [], timeout: 50.0)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
