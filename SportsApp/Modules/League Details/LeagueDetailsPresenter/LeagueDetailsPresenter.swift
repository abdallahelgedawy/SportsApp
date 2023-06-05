//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 25/05/2023.
//

import Foundation
class LeagueDetailsPresenter{
    var view : LeagueDetailsProtoocol?
    var data : [leagues]?
    func attachView(view : LeagueDetailsProtoocol){
        self.view = view
    }
    func getDetalailedLeagues(url : URL , id : Int){
        let result = url.absoluteString + "\(id)"
        let url = URL(string: result)
        print("abdallah \(url)")
        NetworkService.fetchTennis(completionHandler: { leagues in
            self.view?.updateData(data: leagues ?? [])
           
        }, url: url!)
    }
    func getDetalailedLatest(url : URL , id : Int){
        let result = url.absoluteString + "\(id)"
        let url = URL(string: result)
        print("abdallah \(url)")
        NetworkService.fetchTennis(completionHandler: { leagues in
            self.view?.updateLatest(data: leagues ?? [])
           
        }, url: url!)
    }
    func getLogoTeam(url : URL , id : Int){
        let result = url.absoluteString + "\(id)"
        let url = URL(string: result)
        print("dido \(url)")
        NetworkService.fetchTeams(compilationHandler: { teams in
            print("iam here recieve data from Api teams")
            self.view?.updateTeams(data: teams ?? [])
           
        }, url: url!)
    }
    
}
