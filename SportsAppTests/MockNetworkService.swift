//
//  MockNetworkService.swift
//  SportsAppTests
//
//  Created by Abdallah Elgedawy on 29/05/2023.
//

import Foundation
@testable import SportsApp


class MockNetworkService {
    var shouldReturnError : Bool
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    
    enum ResponseWithError : Error {
        case responseError
        
    }
    
    func fetchData(completionHandler: @escaping ([leagues]?) -> Void) {
        if shouldReturnError {
            completionHandler(nil)
        }else {
            let result = try?JSONDecoder().decode(allLeagues.self, from: ApiResponseJson.upcomingFixtureResponse.data(using: .utf8)!)
            completionHandler(result?.result)
        }
        
    }
}


    



