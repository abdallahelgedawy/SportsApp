//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 22/05/2023.
//

import UIKit
import Reachability

class FavoriteViewController: UIViewController{
    var reachability : Reachability?
    @IBOutlet weak var table: UITableView!
    var team : [teams]?
    var league : [leagues]?
    var presenter : favoritePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = try? Reachability()
        tabBarController?.tabBar.isHidden = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.black
        presenter = favoritePresenter()
        presenter?.attachView(myView: self)
        presenter?.retrieveData()
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        presenter?.retrieveData()
    }
    
    

}
protocol favoriteProtocol {
    func updateTable(league : [leagues] , team : [teams])

}
extension FavoriteViewController :UITableViewDataSource , UITableViewDelegate , favoriteProtocol{
    
    
    func updateTable(league: [leagues], team: [teams]) {
        self.team = team
        self.league = league
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "favorite", for: indexPath)
        cell.textLabel?.text = team![indexPath.row].team_name
        cell.textLabel?.textColor = UIColor.orange
        print("gedo",team?[indexPath.row].team_logo)
        let favImage = URL(string:team?[indexPath.row].team_logo ?? "notfound")
        cell.imageView?.sd_setImage(with: favImage, placeholderImage: UIImage(named: "notfound"))
        cell.imageView?.contentMode = .scaleAspectFit
        cell.layer.cornerRadius = cell.frame.size.height / 8
        cell.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(reachability?.connection == Reachability.Connection.unavailable){
            let alertController = UIAlertController(title: "Alert", message: "Check Your Internet Connection!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else{
            let teamDetails = storyboard?.instantiateViewController(withIdentifier: "teamDetails") as? TeamDetailsViewController
            teamDetails?.id = team?[indexPath.row].team_key
            navigationController?.pushViewController(teamDetails!, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let teamId = team?[indexPath.row].team_key
            let deleteAlert : UIAlertController = UIAlertController(title: "Delete", message: "Are You Sure You Want To Delete This Team ", preferredStyle: .alert)
            deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default , handler: { _ in
                self.presenter?.deleteData(id: teamId!)
                self.team?.remove(at: indexPath.row)
                self.table.reloadData()
                
            }))
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(deleteAlert,animated: true,completion: nil)
            
        }
        
        
        
        
    }
    
    
    
    /* func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
         // Delete the row from the data source
         let teamName = savedTeams[indexPath.row].savedTeamName
         let deleteAlert : UIAlertController = UIAlertController(title: "Information", message: "Are You Sure You Want To Delete This Team ", preferredStyle: .alert)
         deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default , handler: { _ in
             self.deletMyFavTeam(name: teamName)
             self.savedTeams.remove(at: indexPath.row)
             self.favoriteTable.deleteRows(at: [indexPath], with: .left)
 
         }))
         deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
         self.present(deleteAlert,animated: true,completion: nil)

     }
 }*/

   
}
