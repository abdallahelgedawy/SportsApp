//
//  NetworkServiceTests.swift
//  SportsAppTests
//
//  Created by Abdallah Elgedawy on 02/06/2023.
//

import XCTest
@testable import SportsApp

final class NetworkServiceTests: XCTestCase {
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    func testFetchData(){
        let myExpectation = expectation(description: "Waiting for the Data")
        NetworkService.fetchData(completionHandler: { items in
            guard let items = items else {
                XCTFail()
                myExpectation.fulfill()
                return
        }
            XCTAssertNotEqual(items.count, 0)
            myExpectation.fulfill()
        }, url: URL(string: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=8f881a3db95100d58a23fb9dd2b9fbcf9a910ad6d99d3e4e8f542dd6bb31a356")!)
        
        waitForExpectations(timeout: 5)
    }

    
    func testFetchTennis(){
        let myExpectation = expectation(description: "Waiting for the Data")
        NetworkService.fetchTennis(completionHandler: { items in
            guard let items = items else {
                XCTFail()
                myExpectation.fulfill()
                return
        }
            XCTAssertNotEqual(items.count, 0)
            myExpectation.fulfill()
        }, url: URL(string: "https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=8f881a3db95100d58a23fb9dd2b9fbcf9a910ad6d99d3e4e8f542dd6bb31a356")!)
        waitForExpectations(timeout: 10)
    }
    func testFetchTeams(){
        let myExpectation = expectation(description: "Waiting for the Data")
        NetworkService.fetchTeams(compilationHandler: { items in
            guard let items = items else {
                XCTFail()
                myExpectation.fulfill()
                return
        }
            XCTAssertNotEqual(items.count, 0)
            myExpectation.fulfill()
        }, url: URL(string: "https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=8f881a3db95100d58a23fb9dd2b9fbcf9a910ad6d99d3e4e8f542dd6bb31a356&leagueId=3")!)
        waitForExpectations(timeout: 10)
    }
    func testFetchPlayers(){
        let myExpectation = expectation(description: "Waiting for the Data")
        NetworkService.fetchPlayers(compilationHandler: { items in
            guard let items = items else {
                XCTFail()
                myExpectation.fulfill()
                return
        }
            XCTAssertNotEqual(items.count, 0)
            myExpectation.fulfill()
        }, url: URL(string: "https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=8f881a3db95100d58a23fb9dd2b9fbcf9a910ad6d99d3e4e8f542dd6bb31a356&teamId=72")!)
        waitForExpectations(timeout: 10)
    }
    func testFetchPlayersShouldFail(){
        let myExpectation = expectation(description: "Waiting for the Data")
        NetworkService.fetchPlayers(compilationHandler: { items in
            guard let items = items else{
                XCTAssertNil(items)
                myExpectation.fulfill()
                return
            }
        },
            
         url: URL(string: "https://apiv.allsportsapi.com/football/?met=Teams&APIkey=8f881a3db95100d58a23fb9dd2b9fbcf9a910ad6d99d3e4e8f542dd6bb31a356&teamId=72")!)
        waitForExpectations(timeout: 5)
    }
    
}
