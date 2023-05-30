//
//  ViewController.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 20/05/2023.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollection.delegate = self
        homeCollection.dataSource = self
        let layout = homeCollection.collectionViewLayout as! UICollectionViewFlowLayout

        layout.itemSize = CGSize(width: homeCollection.bounds.width*0.6, height: homeCollection.bounds.width*0.3)
        
        
        
    }
    var colors = [UIColor(named: "red" ) , UIColor(named: "blue")]
    var names = ["FOOTBALL" , "BASKETBALL" , "TENNIS" , "CRICKET"]
    var images = [UIImage(named: "football2") , UIImage(named: "basketball") , UIImage(named: "tennis") , UIImage(named: "cricket")]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollection.dequeueReusableCell(withReuseIdentifier: "home", for: indexPath) as! HomeCollectionViewCell
        cell.sportsLabel.text = names[indexPath.row]
        cell.sportsImage.image = images[indexPath.row]
        cell.layer.cornerRadius = cell.frame.size.height / 10
        
        
        return cell
    }
    
   

    

    @IBOutlet weak var homeCollection: UICollectionView!
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var leagues = storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesTableViewController
        leagues.modalPresentationStyle = .fullScreen
        leagues.modalTransitionStyle = .crossDissolve
        leagues.label = names[indexPath.row]
        navigationController?.pushViewController(leagues, animated: true)
    }

}

