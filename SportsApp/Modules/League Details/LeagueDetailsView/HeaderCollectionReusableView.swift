//
//  HeaderCollectionReusableView.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 25/05/2023.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var upcomingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var title : String? {
        didSet{
            upcomingLabel.text = title
        }
    }
}
