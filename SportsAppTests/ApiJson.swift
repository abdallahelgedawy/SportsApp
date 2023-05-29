//
//  ApiJson.swift
//  SportsAppTests
//
//  Created by Abdallah Elgedawy on 29/05/2023.
//

import Foundation
class ApiResponseJson{
    static let upcomingFixtureResponse = """
  {
    "success": 1,
    "result": [
      {
        "event_key": 11774785,
        "event_date": "2023-02-12",
        "event_time": "14:10",
        "event_first_player": "L. Samsonova",
        "first_player_key": 2815,
        "event_second_player": "B. Bencic",
        "second_player_key": 2387,
        "event_final_result": "1 - 2",
        "event_game_result": "-",
        "event_serve": null,
        "event_winner": "Second Player",
        "event_status": "Finished",
        "country_name": "Wta Singles",
        "league_name": "Abu Dhabi",
        "league_key": 3872,
        "league_round": "Abu Dhabi - Final",
        "league_season": "2023",
        "event_live": "0",
        "event_first_player_logo": "https:apiv2.allsportsapi.com815_l-samsonova.jpg",
        "event_second_player_logo": "https:apiv2.allsportsapi.com387_b-bencic.jpg",
        "pointbypoint": [
          
        ],
        "scores": [
          {
            "score_first": "6",
            "score_second": "1",
            "score_set": "1"
          },
          {
            "score_first": "6.8",
            "score_second": "7.10",
            "score_set": "2"
          },
          {
            "score_first": "4",
            "score_second": "6",
            "score_set": "3"
            }
        ]
      }
    ]
  }
  """
}

