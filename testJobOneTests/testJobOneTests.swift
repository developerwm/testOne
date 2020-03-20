//
//  testJobOneTests.swift
//  testJobOneTests
//
//  Created by Tauã on 19/03/20.
//  Copyright © 2020 Tauã. All rights reserved.
//

import XCTest
import UIKit
import XCTest
import Foundation
import MockURLSession
import SwiftHTTP

@testable import testJobOne

class HttpClientTests: XCTestCase {
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
}

class testJobOneTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_get_request_URL() {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1") else {
            fatalError("empty")
        }
        
        HTTP.GET(url.description) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                fatalError("empty")
                return //also notify app of failure as needed
            }
            print("opt finished: \(response.description)")
            //print("data is: \(response.data)") access the response of the data with response.data
        }
        
        // Assert
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
    
}
