//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 22/05/2023.
//

import UIKit
import SDWebImage

class LeaguesTableViewController: UITableViewController , LeaguesProtocol,  UISearchBarDelegate {
   
    
    var label : String?
    var data : [leagues?] = []
    var filteredResults: [leagues?] = []
    var filteredImag : [String?] = []
    var isSearched : Bool?
    
    var leaguesPresenter : LeaguePresenter?
    let networkIndicator=UIActivityIndicatorView(style: .large)
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
          searchController.obscuresBackgroundDuringPresentation = false
          searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        isSearched = false
          tableView.tableHeaderView = searchController.searchBar
          definesPresentationContext = true
    let swipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
            swipeGesture.edges = .left
            view.addGestureRecognizer(swipeGesture)
        networkIndicator.color=UIColor.orange
        networkIndicator.center=view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
        leaguesPresenter = LeaguePresenter()
        leaguesPresenter?.attachView(view: self)
        if(label == "FOOTBALL"){
            let url = Constants.url + "/football/?met=Leagues&APIkey=" + Constants.apiKey
            print(url)
            let result = URL(string: url)
            leaguesPresenter?.getLeagues(url: result!)
        }
        if(label == "BASKETBALL"){
            let url = Constants.url + "/basketball/?met=Leagues&APIkey=" + Constants.apiKey
            let result = URL(string: url)
            leaguesPresenter?.getLeagues(url: result!)
        }
        if(label == "TENNIS"){
            let url = Constants.url + "/tennis/?met=Leagues&APIkey=" + Constants.apiKey
            let result = URL(string: url)
            leaguesPresenter?.getLeagues(url: result!)
        }
        if(label == "CRICKET"){
            let url = Constants.url + "/cricket/?met=Leagues&APIkey=" + Constants.apiKey
            let result = URL(string: url)
            leaguesPresenter?.getLeagues(url: result!)
        }
       

    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearched = false
            filteredResults.removeAll()
           
        }
        else {
            isSearched = true
            filteredResults.removeAll()
            filteredResults = data.filter{league in return
                (league?.league_name?.contains(searchText))!
            }
                
            }
        
           
            
            tableView.reloadData()
    }
    

    @objc func handleSwipeGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .recognized {
            self.dismiss(animated: true)
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isSearched == true {
            return filteredResults.count
        }
        else {
            return data.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagues", for: indexPath)as! LeaguesTableViewCell
        cell.leaguesImage.contentMode = .scaleToFill
        cell.leaguesImage.layer.cornerRadius = cell.leaguesImage.frame.size.width / 4
        cell.leaguesImage.layer.masksToBounds = true
        cell.layer.cornerRadius = cell.frame.size.height / 8
        if isSearched!{
            
            cell.leaguesLabel.text = filteredResults[indexPath.row]?.league_name
                if let leagueLogoURLString = filteredResults[indexPath.row]?.league_logo, let leagueLogoURL = URL(string: leagueLogoURLString) {
                        cell.leaguesImage.sd_setImage(with: leagueLogoURL, placeholderImage: UIImage(named: "notfound"))
                    } else {
                        cell.leaguesImage.image = UIImage(named: "notfound")
                    }
                
                
            
            } else {
                
                    cell.leaguesLabel.text = data[indexPath.row]?.league_name
                    if let leagueLogoURLString = data[indexPath.row]?.league_logo, let leagueLogoURL = URL(string: leagueLogoURLString) {
                        cell.leaguesImage.sd_setImage(with: leagueLogoURL, placeholderImage: UIImage(named: "notfound"))
                    } else {
                        cell.leaguesImage.image = UIImage(named: "notfound")
                    }
                }
                
            
        
            
            return cell
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func updateTable(data: [leagues?]) {
        self.data = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.networkIndicator.stopAnimating()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var leagueDetails = storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
        if(isSearched == true){
            leagueDetails.label = label
            leagueDetails.modalPresentationStyle = .fullScreen
            leagueDetails.modalTransitionStyle = .crossDissolve
            leagueDetails.leagueId = filteredResults[indexPath.row]?.league_key
            self.present(leagueDetails, animated: true)
        }
        else if(isSearched == false){
            leagueDetails.label = label
            leagueDetails.modalPresentationStyle = .fullScreen
            leagueDetails.modalTransitionStyle = .crossDissolve
            leagueDetails.leagueId = data[indexPath.row]?.league_key
            self.present(leagueDetails, animated: true)
        }
    }
}
protocol LeaguesProtocol : AnyObject{
    func updateTable(data : [leagues?])
}
