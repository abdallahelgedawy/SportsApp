//
//  NetworkService.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 22/05/2023.
//

import Foundation
class NetworkService {
    
    static func fetchData(completionHandler: @escaping ([leagues]?) -> Void, url: URL) {
      //  print("this is url for hit",url)
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Error: No data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(allLeagues.self, from: data)
        //        print("this is result el gedo",result.result![0].event_first_player!)
                completionHandler(result.result)
               // print(result.result!)
              //  print(result.result![0].event_first_player!)
               
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    static func fetchTennis(completionHandler: @escaping ([leagues]?) -> Void, url: URL) {
        print("upcoming and latest url hit",url)
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Error: No data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(allLeagues.self, from: data)
//                print("this is result el gedo",result.result![0].home_team_logo!)
                completionHandler(result.result)
                print(result.result?[0].event_first_player)
               // print(result.result!)
              //  print(result.result![0].event_first_player!)
               
            } catch {
                completionHandler(nil)
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
    
        
        task.resume()
    }
    static func fetchTeams(compilationHandler : @escaping (([teams]?)->Void) , url : URL){
        print("i will send data from teams network before decodeing")
        let request = URLRequest(url:url)
     
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){
            [self] data, response, error in
            guard let result = try? JSONDecoder().decode(allTeams.self, from: data!) else{return}
            print("i will send data from teams network")
            compilationHandler(result.result)
           
           // print("aaaa \(result.resultTeams![0].team_name)")
        }
        compilationHandler(nil)
        task.resume()

    }
    static func fetchPlayers(compilationHandler : @escaping ([teams]?)->Void , url : URL){
        let request = URLRequest(url:url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){
            [self] data, response, error in
            guard let result = try? JSONDecoder().decode(allTeams.self, from: data!) else{return}
            compilationHandler(result.result)
            print("aaaas", result.result?[0].players?[0].player_name)
        }
        compilationHandler(nil)
        task.resume()

    }
}
