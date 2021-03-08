//
//  LeaderboardEntryTableViewCell.swift
//  PollenPanic
//
//  Created by Liam Sutton on 05/03/2021.
//
import UIKit

// Used to model a custom tableviewcell for leaderboard entries
class LeaderboardEntryTableViewCell : UITableViewCell {
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }

}
