//
//  CacheService.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 22/05/2023.
//

import Foundation
import CoreData
import UIKit
class CacheService {
    let context: NSManagedObjectContext?
       static let getInstance = CacheService()
      private init() {
          print("single object created")
          let appDelegate=UIApplication.shared.delegate as! AppDelegate
          context=appDelegate.persistentContainer.viewContext
       }
    func insertTeam(data:leagues, dataTeams : teams , completion : @escaping (Bool)-> Void){
           let fetchRequest=NSFetchRequest<NSManagedObject>(entityName: "Teams")
        let predicate = NSPredicate(format: "teamId == %d", dataTeams.team_key!)
           fetchRequest.predicate=predicate
           do{
               let existingTeams = try context?.fetch(fetchRequest)
               if existingTeams?.isEmpty ?? true {
                   let entity=NSEntityDescription.entity(forEntityName: "Teams", in: context!)
                   let team=NSManagedObject(entity: entity!, insertInto: context)
                   team.setValue(dataTeams.team_name, forKey: "teamName")
                   team.setValue(dataTeams.team_logo, forKey: "teamImage")
                   team.setValue(data.league_key, forKey: "leagueId")
                   team.setValue(dataTeams.team_key, forKey: "teamId")
                   try  context?.save()
                   print("added successfully")
                   completion(true)
               }else{
                   print("The item already exists")
                   completion(false)
               }
               
               }catch{
                   print("an error occured in add")
                   completion(false)
               }
       }
    
       func deleteTeam(teamId:Int , completion : @escaping (Bool)-> Void){
           let fetchRequest=NSFetchRequest<NSManagedObject>(entityName: "Teams")
           let predicate=NSPredicate(format: "teamId == %d",teamId)
           fetchRequest.predicate=predicate
           do {
               let teams=try context!.fetch(fetchRequest)
                context!.delete(teams[0])
                try context!.save()
               completion(true)
                print("deletedSuccessfully")
           } catch {
               completion(false)
               print("eroor in delete")
           }
      
       }
    
       func getAllTeams(completion : @escaping ([teams]? , [leagues]?)-> Void){
           var retrievedArray = [teams]()
           var retrievedArrayLeagues = [leagues]()
           let fetchRequest=NSFetchRequest<NSManagedObject>(entityName: "Teams")
           do{
               let allTeams=try context!.fetch(fetchRequest)
               for team in allTeams {
                   let teamsaved = teams()
                   let leagueSaved = leagues()
                   teamsaved.team_key=team.value(forKey: "teamId") as? Int
                   teamsaved.team_name=team.value(forKey: "teamName") as? String
                   leagueSaved.league_key=team.value(forKey: "leagueId") as? Int
                   teamsaved.team_logo=team.value(forKey: "teamImage")as? String
                   retrievedArray.append(teamsaved)
                   retrievedArrayLeagues.append(leagueSaved)
                   print(teamsaved.team_name)
               }
               print(retrievedArray.count)
               // if empty will return []
               print("data retrived succsessfully")
             //  print(retrievedArray)
               completion(retrievedArray , retrievedArrayLeagues)
           }catch{
               print("error")
               completion(nil , nil)
               
           }
       }
}
