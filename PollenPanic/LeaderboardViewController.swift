//
//  LeaderboardViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 28/02/2021.
//

import UIKit
class LeaderboardViewController : UIViewController {
    var db:DatabaseHelper = DatabaseHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        let entries:[LeaderBoardEntry] = db.getLeaderboardData()
    }
}
