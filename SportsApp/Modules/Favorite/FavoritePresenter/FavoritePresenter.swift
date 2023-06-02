//
//  FavoritePresenter.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 31/05/2023.
//

import Foundation
class favoritePresenter {
    var view : favoriteProtocol?
    var team : [teams]?
    var league : [leagues]?
    var database = CacheService.getInstance
    func attachView(myView : favoriteProtocol){
        self.view = myView
    }
    func retrieveData(){
        database.getAllTeams { team, leagues in
            self.view?.updateTable(league: leagues!, team: team!)
        }
    }
    func deleteData(id:Int){
            database.deleteTeam(teamId: id) { status in
                if(status == true){ 
                    print("Deleted")
                }
            }
        }
    }

