//
//  LeaderboardViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 28/02/2021.
//

import UIKit
class LeaderboardViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var db:DatabaseHelper = DatabaseHelper()
    var entries:[LeaderBoardEntry] = []
    let cellIdentifier:String = "leaderboardEntryCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        entries = db.getLeaderboardData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! LeaderboardEntryTableViewCell
        
        cell.usernameLabel.text = entries[indexPath.row].getUsername()
        cell.scoreLabel.text = String(entries[indexPath.row].getScore())
        
        return cell
    }
}
