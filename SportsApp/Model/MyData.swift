//
//  MyData.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 29/05/2023.
//

import Foundation
class allLeagues  : Decodable{
    var success : Int?
    var result : [leagues]?
}
class leagues : Decodable{
    var league_key : Int?
    var league_name : String?
    var country_name : String?
    var league_logo : String?
    var event_home_team : String?
    var event_date_stop : String?
    var event_date : String?
    var event_time : String?
    var home_team_logo : String?
    var event_away_team : String?
    var away_team_logo : String?
    var event_final_result : String?
    var event_first_player : String?
    var event_second_player : String?
    var event_first_player_logo : String?
    var event_second_player_logo : String?
    var event_home_team_logo : String?
    var event_away_team_logo : String?
    var event_home_final_result : String?
    var event_away_final_result : String?
}
class allTeams : Decodable{
    var success : Int?
    var result : [teams]?
}
class teams : Decodable{
    var team_key : Int?
    var team_name : String?
    var team_logo : String?
    var players : [allPlayers]?
    var coaches : [allCoaches]?
}
class allPlayers : Decodable{
    var player_name: String?
    var player_number : String?
    var player_type : String?
    var player_age : String?
    var player_image : String?

}
class allCoaches : Decodable{
    var coach_name : String?
}






       
     
 
