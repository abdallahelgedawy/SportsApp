//
//  TeamDetailsPresenter.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 29/05/2023.
//

import Foundation
class TeamDetailsPresenter{
    var presenter : TeamDetailsProtocol?
    func attachView(view : TeamDetailsProtocol){
        self.presenter = view
    }
    func getPlayers(url : URL , id : Int){
        let result = url.absoluteString + "\(id)"
        let url = URL(string: result)
        print(url)
        NetworkService.fetchPlayers(compilationHandler: { players in
            self.presenter?.updatePlayers(data: players ?? [] )
            
        }, url: url!)
    }
}
