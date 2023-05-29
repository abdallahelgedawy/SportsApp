//
//  LeaguePresenter.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 23/05/2023.
//

import Foundation
class LeaguePresenter{
    var view : LeaguesProtocol?
    var data : [leagues]?
    func attachView(view : LeaguesProtocol){
        self.view = view
    }
    func getLeagues(url : URL){
        NetworkService.fetchData(completionHandler: { myleagues in
            self.view?.updateTable(data: myleagues!)
        }, url: url)
    }

}
