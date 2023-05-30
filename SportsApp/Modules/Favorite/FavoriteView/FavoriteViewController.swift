//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 22/05/2023.
//

import UIKit

class FavoriteViewController: UIViewController  , UITableViewDataSource , UITableViewDelegate  {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.black
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tabBarController?.tabBar.isHidden = false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "favorite", for: indexPath)
        cell.textLabel?.text = "Gedo"
        cell.textLabel?.textColor = UIColor.orange
        cell.layer.cornerRadius = cell.frame.size.height / 8
        cell.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
   
   

}
