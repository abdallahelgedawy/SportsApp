//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 22/05/2023.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {
    @IBOutlet weak var leaguesImage: UIImageView!
    
    @IBOutlet weak var leaguesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
