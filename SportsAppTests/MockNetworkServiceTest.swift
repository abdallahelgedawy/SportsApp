//
//  MockNetworkServiceTest.swift
//  SportsAppTests
//
//  Created by Abdallah Elgedawy on 29/05/2023.
//

import XCTest
@testable import SportsApp
final class MockNetworkServiceTest: XCTestCase {
    var mocknetworkService = MockNetworkService(shouldReturnError: false)
    func testfetchDataShouldPass(){
        let myExpectation = expectation(description: "Waiting for the Data")
        mocknetworkService.fetchData { items  in
            guard let items = items else {
                XCTFail()
                myExpectation.fulfill()
                return
            }
            //"L. Samsonova"
            XCTAssertEqual(items[0].event_first_player, "L. Samsonova")
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    func testfetchDataShouldFail(){
        mocknetworkService = MockNetworkService(shouldReturnError: true)
        let myExpectation = expectation(description: "Waiting for the Data")
        mocknetworkService.fetchData { items  in
           XCTAssertNil(items)
            myExpectation.fulfill()
            }
            
        waitForExpectations(timeout: 5)}

}
