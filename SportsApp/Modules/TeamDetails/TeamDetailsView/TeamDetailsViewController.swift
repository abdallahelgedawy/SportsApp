//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 29/05/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    @IBOutlet weak var teamImage: UIImageView!
    var id : Int?
    var teamData : [teams] = []
    var playersArray : [allPlayers] = []
    var coachArray : [allCoaches] = []
    @IBOutlet weak var teamNameLabel: UILabel!
    var presenter : TeamDetailsPresenter?
    var league = leagues()
   
    @IBOutlet weak var coachNameLabel: UILabel!
    let networkIndicator=UIActivityIndicatorView(style: .large)
    @IBOutlet weak var teamDetailsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        league.league_key = id
        let swipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.edges = .left
        view.addGestureRecognizer(swipeGesture)
        teamDetailsCollection.delegate = self
        teamDetailsCollection.dataSource = self
        networkIndicator.color=UIColor.orange
        networkIndicator.center=view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
        presenter = TeamDetailsPresenter()
        presenter?.attachView(view: self)
        let playersUrl = Constants.url + "/football/?met=Teams&APIkey=" + Constants.apiKey + "&teamId="
        let resultPlayers = URL(string: playersUrl)
        presenter?.getPlayers(url: resultPlayers!, id: id!)
        let layout = teamDetailsCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: teamDetailsCollection.bounds.width/2, height: teamDetailsCollection.bounds.height)
    }
  
    @IBAction func favButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to add this item to favorite?", preferredStyle: .alert)
       
            let okAction = UIAlertAction(title: "Yes", style: .default) { (_) in
                self.presenter?.insertInDatabase(team: self.teamData[0], league: self.league)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
                // Handle Cancel button action
            }
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        
    }
}
extension TeamDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , TeamDetailsProtocol {
    func updatePlayers(data: [teams]) {
        self.teamData = data
        if let firstTeam = teamData.first, let teamPlayers = firstTeam.players {
               playersArray = teamPlayers
               
           } else {
               playersArray = []
           }
        if let firstCoach = teamData.first , let coach = firstCoach.coaches{
            coachArray = coach
        }
        else {
            coachArray = []
        }
        print("gedo",playersArray.count)
       // print("gedo",teamData.count)
        DispatchQueue.main.async {
            self.teamDetailsCollection.reloadData()
            self.networkIndicator.stopAnimating()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = teamDetailsCollection.dequeueReusableCell(withReuseIdentifier: "teamDetails", for: indexPath) as! TeamDetailsCollectionViewCell
        let playersImage = URL(string: playersArray[indexPath.row].player_image ?? "notfound")
        cell.playerImage.sd_setImage(with: playersImage ,placeholderImage : UIImage(named: "notfound") )
        teamNameLabel.text = teamData[0].team_name
        teamNameLabel.adjustsFontSizeToFitWidth = true
        coachNameLabel.adjustsFontSizeToFitWidth = true
        coachNameLabel.text = coachArray[0].coach_name
        let teamimage = URL(string: teamData[0].team_logo ?? "notfound")
        teamImage.sd_setImage(with: teamimage, placeholderImage: UIImage(named: "notfound"))
        teamImage.contentMode = .scaleAspectFill
        teamImage.layer.cornerRadius = teamImage.frame.size.width/3
        teamImage.layer.masksToBounds = true
        cell.playerImage.contentMode = .scaleAspectFill
        cell.playerImage.layer.cornerRadius = cell.playerImage.frame.size.width / 3
        cell.playerImage.layer.masksToBounds = true
        cell.positionLabel.adjustsFontSizeToFitWidth = true
        cell.nameLabel.adjustsFontSizeToFitWidth = true
        cell.nameLabel.text = playersArray[indexPath.row].player_name
        cell.ageLabel.text =  playersArray[indexPath.row].player_age
        cell.numberLabel.text =  playersArray[indexPath.row].player_number
        cell.positionLabel.text =  playersArray[indexPath.row].player_type
       
        cell.layer.cornerRadius = cell.frame.size.height / 5
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: 190, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    @objc func handleSwipeGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .recognized {
            self.dismiss(animated: true)
        }
    }

}
protocol TeamDetailsProtocol{
    func updatePlayers(data : [teams])
}
