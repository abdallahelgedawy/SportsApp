//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 24/05/2023.
//

import UIKit
import SDWebImage
import Reachability
protocol LeagueDetailsProtoocol{
    func updateData(data : [leagues?])
    func updateLatest(data : [leagues?])
    func updateTeams(data : [teams?])
    
}

class LeagueDetailsViewController: UIViewController   {
    
    var reachability : Reachability?
    @IBOutlet weak var leagueDetailsCollection: UICollectionView!
    var leagueId : Int?
    var data : [leagues?] = []
    var data2 : [leagues?] = []
    var logos : [teams?] = []
    var label : String?
    var detailsLeaguePresenter : LeagueDetailsPresenter?
    let networkIndicator=UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        print(label)
        reachability = try? Reachability()
        networkIndicator.color=UIColor.orange
        networkIndicator.center=view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
        detailsLeaguePresenter = LeagueDetailsPresenter()
        detailsLeaguePresenter?.attachView(view: self)
        if(label == "FOOTBALL"){
            let url = Constants.url + "/football/?met=Fixtures&APIkey=" + Constants.apiKey +  "&from=2023-05-13&to=2023-06-23&leagueId="
            let result = URL(string: url)
            detailsLeaguePresenter?.getDetalailedLeagues(url: result!, id: leagueId!)
            let urlLogo = Constants.url + "/football/?met=Teams&APIkey=" + Constants.apiKey + "&leagueId="
            let resultLogo = URL(string: urlLogo)
            detailsLeaguePresenter?.getLogoTeam(url: resultLogo!, id: leagueId!)
            let latestUrl = Constants.url + "/football/?met=Fixtures&APIkey=" + Constants.apiKey + "&from=2023-03-13&to=2023-05-25&leagueId="
            let resultLatest = URL(string: latestUrl)
            detailsLeaguePresenter?.getDetalailedLatest(url: resultLatest!, id: leagueId!)
        }
        else if(label == "BASKETBALL"){
            let url = Constants.url + "/basketball/?met=Fixtures&APIkey=" + Constants.apiKey +  "&from=2023-05-13&to=2023-06-23&leagueId="
            let result = URL(string: url)
            detailsLeaguePresenter?.getDetalailedLeagues(url: result!, id: leagueId!)
            let urlLogo = Constants.url + "/basketball/?met=Teams&APIkey=" + Constants.apiKey + "&leagueId="
            let resultLogo = URL(string: urlLogo)
            detailsLeaguePresenter?.getLogoTeam(url: resultLogo!, id: leagueId!)
            let latestUrl = Constants.url + "/basketabll/?met=Fixtures&APIkey=" + Constants.apiKey + "&from=2023-03-13&to=2023-05-25&leagueId="
            let resultLatest = URL(string: latestUrl)
            detailsLeaguePresenter?.getDetalailedLatest(url: resultLatest!, id: leagueId!)
        }
        else if(label == "CRICKET"){
            let url = Constants.url + "/cricket/?met=Fixtures&APIkey=" + Constants.apiKey +  "&from=2023-05-13&to=2023-06-23&leagueId="
            let result = URL(string: url)
            detailsLeaguePresenter?.getDetalailedLeagues(url: result!, id: leagueId!)
            let urlLogo = Constants.url + "/cricket/?met=Teams&APIkey=" + Constants.apiKey + "&leagueId="
            let resultLogo = URL(string: urlLogo)
            detailsLeaguePresenter?.getLogoTeam(url: resultLogo!, id: leagueId!)
            let latestUrl = Constants.url + "/cricket/?met=Fixtures&APIkey=" + Constants.apiKey + "&from=2023-03-13&to=2023-05-25&leagueId="
            let resultLatest = URL(string: latestUrl)
            detailsLeaguePresenter?.getDetalailedLatest(url: resultLatest!, id: leagueId!)
        }
        else if(label == "TENNIS") {
            let url = Constants.url + "/tennis/?met=Fixtures&APIkey=" + Constants.apiKey +  "&from=2023-05-28&to=2023-06-30&leagueId="
            let result = URL(string: url)
            detailsLeaguePresenter?.getDetalailedLeagues(url: result!, id: leagueId!)
            let urlLogo = Constants.url + "/tennis/?met=Teams&APIkey=" + Constants.apiKey + "&leagueId="
            let resultLogo = URL(string: urlLogo)
            detailsLeaguePresenter?.getLogoTeam(url: resultLogo!, id: leagueId!)
            let latestUrl = Constants.url + "/tennis/?met=Fixtures&APIkey=" + Constants.apiKey + "&from=2022-05-25&to=2023-05-28&leagueId="
            let resultLatest = URL(string: latestUrl)
            detailsLeaguePresenter?.getDetalailedLatest(url: resultLatest!, id: leagueId!)
    //        print("aloo \(data[0]?.event_first_player)")

        }
        leagueDetailsCollection.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "header")
        leagueDetailsCollection.register(UINib(nibName: "LeagueDetailsCell", bundle: nil), forCellWithReuseIdentifier: "latestCell")
        let swipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.edges = .left
        view.addGestureRecognizer(swipeGesture)
        leagueDetailsCollection.delegate = self
        leagueDetailsCollection.dataSource = self
        leagueDetailsCollection.register(UINib(nibName: "LeagueDetailsCell", bundle: nil), forCellWithReuseIdentifier: "leagueDetailsCell")
        let layout = UICollectionViewCompositionalLayout {
            index , environment in
            switch index {
            case 0 :
                    return self.drawTopSection()
            case 1 :
                return self.drawCenterSection()
            case 2 :
                return self.drawBottomSection()
            default:
                return nil
            }
            
        }
        
        leagueDetailsCollection.setCollectionViewLayout(layout, animated: true)
    }

}


extension LeagueDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , LeagueDetailsProtoocol{
    func updateData(data: [leagues?]) {
        self.data = data
        DispatchQueue.main.async {
            self.leagueDetailsCollection.reloadData()
            self.networkIndicator.stopAnimating()
        }
    }
    func drawCenterSection()->NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.accessibilityScroll(UIAccessibilityScrollDirection.down)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
            
        return section
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0 :
            return data.count
        case 1 :
            return data2.count
        case 2 :
            return logos.count
        default :
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0 :
            
            let cell = leagueDetailsCollection.dequeueReusableCell(withReuseIdentifier: "leagueDetailsCell", for: indexPath)
            as! LeagueDetailsCollectionViewCell
            if(label == "TENNIS"){
                let homeImage = URL(string: data[indexPath.row]!.event_first_player_logo ?? "nptfound")
                cell.homeImage.sd_setImage(with: homeImage , placeholderImage: UIImage(named: "notfound"))
                let awayImage = URL(string: data[indexPath.row]!.event_second_player_logo ?? "notfound")
                cell.myAwayImage.sd_setImage(with: awayImage , placeholderImage: UIImage(named: "notfound"))
                cell.myawayLabel.adjustsFontSizeToFitWidth = true
                cell.homeLabel.adjustsFontSizeToFitWidth = true
                cell.dateLabel.adjustsFontSizeToFitWidth = true
                cell.myawayLabel.text = data[indexPath.row]?.event_first_player
                cell.homeLabel.text = data[indexPath.row]?.event_second_player
                cell.vsLabel.text = "VS"
                cell.dateLabel.text = data[indexPath.row]?.event_date
                cell.timeLabel.text = data[indexPath.row]?.event_time
                cell.layer.cornerRadius = cell.frame.size.height/3
                return cell
            
            }
            else{
                let homeImage = URL(string: data[indexPath.row]!.home_team_logo ?? "notfound")
                cell.homeImage.sd_setImage(with: homeImage , placeholderImage: UIImage(named: "notfound"))
                let awayImage = URL(string: data[indexPath.row]!.away_team_logo ?? "notfound")
                cell.myAwayImage.sd_setImage(with: awayImage , placeholderImage: UIImage(named: "notfound"))
                cell.myawayLabel.adjustsFontSizeToFitWidth = true
                cell.homeLabel.adjustsFontSizeToFitWidth = true
                cell.dateLabel.adjustsFontSizeToFitWidth = true
                cell.myawayLabel.text = data[indexPath.row]?.event_home_team
                cell.homeLabel.text = data[indexPath.row]?.event_away_team
                cell.vsLabel.text = "VS"
                cell.dateLabel.text = data[indexPath.row]?.event_date
                cell.timeLabel.text = data[indexPath.row]?.event_time
                cell.layer.cornerRadius = cell.frame.size.height/3
                return cell
            }
        case 1 :
            let cell = leagueDetailsCollection.dequeueReusableCell(withReuseIdentifier: "latestCell", for: indexPath)as! LeagueDetailsCollectionViewCell
            if(label == "TENNIS"){
                let homeImage = URL(string: data2[indexPath.row]!.event_first_player_logo ?? "notfound")
                cell.homeImage.sd_setImage(with: homeImage , placeholderImage: UIImage(named: "notfound"))
                let awayImage = URL(string: data2[indexPath.row]!.event_second_player_logo ?? "notfound")
                cell.myAwayImage.sd_setImage(with: awayImage , placeholderImage: UIImage(named: "notfound"))
                
                cell.myawayLabel.adjustsFontSizeToFitWidth = true
                cell.homeLabel.adjustsFontSizeToFitWidth = true
                cell.dateLabel.adjustsFontSizeToFitWidth = true
                cell.myawayLabel.text = data2[indexPath.row]?.event_first_player
                cell.homeLabel.text = data2[indexPath.row]?.event_second_player
                cell.vsLabel.text = "VS"
                cell.dateLabel.text = data2[indexPath.row]?.event_final_result
                cell.timeLabel.text = data2[indexPath.row]?.event_time
                cell.layer.cornerRadius = cell.frame.size.height/3
                return cell
            }
            else{
                let homeImage = URL(string: data2[indexPath.row]!.home_team_logo ?? "notfound")
                cell.homeImage.sd_setImage(with: homeImage , placeholderImage: UIImage(named: "notfound"))
                let awayImage = URL(string: data2[indexPath.row]!.away_team_logo ?? "notfound")
                cell.myAwayImage.sd_setImage(with: awayImage , placeholderImage: UIImage(named: "notfound"))
                cell.myawayLabel.adjustsFontSizeToFitWidth = true
                cell.homeLabel.adjustsFontSizeToFitWidth = true
                cell.dateLabel.adjustsFontSizeToFitWidth = true
                cell.myawayLabel.text = data2[indexPath.row]?.event_home_team
                cell.homeLabel.text = data2[indexPath.row]?.event_away_team
                cell.vsLabel.text = "VS"
                cell.dateLabel.text = data2[indexPath.row]?.event_final_result
                cell.timeLabel.text = ""
                cell.layer.cornerRadius = cell.frame.size.height/2
                return cell
            }
        case 2 :
            let cell = leagueDetailsCollection.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
            let teamImage = URL(string: logos[indexPath.row]!.team_logo ?? "notfound")
            cell.teamImage.sd_setImage(with: teamImage ,placeholderImage : UIImage(named: "notfound") )
            cell.teamImage.contentMode = .scaleAspectFit
            cell.teamImage.layer.cornerRadius = cell.teamImage.frame.size.width / 3
            cell.teamImage.layer.masksToBounds = true
            cell.layer.cornerRadius = cell.frame.size.height/10
            return cell
        default :
            return UICollectionViewCell()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 400)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = leagueDetailsCollection.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionReusableView
        switch indexPath.section{
        case 0 :
            view.title = "Upcoming Events"
            return view
        case 1 : view.title = "Latest Results"
            return view
        case 2 : view.title = "Teams"
        default:
            return view
        }
        
        return view
    }

    
    @objc func handleSwipeGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .recognized {
            self.dismiss(animated: true)
        }
    }
    func drawTopSection()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    func drawBottomSection()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    func updateLatest(data: [leagues?]) {
        self.data2 = data
        DispatchQueue.main.async {
            self.leagueDetailsCollection.reloadData()
        }
    }
    func updateTeams(data: [teams?]) {
        self.logos = data
        DispatchQueue.main.async {
            self.leagueDetailsCollection.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(reachability?.connection == Reachability.Connection.unavailable){
            let alertController = UIAlertController(title: "Alert", message: "Check Your Internet Connection!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else{
            switch (indexPath.section){
            case 2 :
                print(indexPath.row ,indexPath.section)
                if(label == "FOOTBALL"){
                    let detailsTeams = storyboard?.instantiateViewController(withIdentifier: "teamDetails") as? TeamDetailsViewController
                    detailsTeams?.modalPresentationStyle = .fullScreen
                    detailsTeams!.id = logos[indexPath.row]?.team_key
                    detailsTeams?.modalTransitionStyle = .crossDissolve
                    self.navigationController?.pushViewController(detailsTeams!, animated: true)
                }
                else{
                    let alertController = UIAlertController(title: "Alert", message: "No Team Details Available", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    }
                    
                    alertController.addAction(okAction)
                    
                    present(alertController, animated: true, completion: nil)
                }
            default:
                print("Cannot go to the next screen")
            }
        }
    }
}
