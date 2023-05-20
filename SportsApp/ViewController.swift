//
//  ViewController.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 20/05/2023.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
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
        cell.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        return cell
    }
   

    

    @IBOutlet weak var homeCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollection.delegate = self
        homeCollection.dataSource = self
        let layout = homeCollection.collectionViewLayout as! UICollectionViewFlowLayout
       layout.sectionInset = UIEdgeInsets(top: 10, left:20, bottom: 0, right:20)
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: homeCollection.bounds.width*0.48, height: homeCollection.bounds.width*0.6)
        
        
        
    }
    
   

}

