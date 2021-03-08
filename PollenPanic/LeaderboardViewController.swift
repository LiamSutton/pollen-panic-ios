//
//  LeaderboardViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 28/02/2021.
//

import UIKit
class LeaderboardViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var db:DatabaseHelper = DatabaseHelper() // connection to the database
    var entries:[LeaderBoardEntry] = [] // a list of leaderboard entries pulled from the database
    let cellIdentifier:String = "leaderboardEntryCellIdentifier"
    
    // pulls the information from the database and popluates the tableview with custom cells
    override func viewDidLoad() {
        super.viewDidLoad()
        entries = db.getLeaderboardData()
    }
    
    // get the number of leaderboard entries
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    // use custom cell to display leaderboard entries in the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! LeaderboardEntryTableViewCell
        cell.indexLabel.text = "[\(indexPath.row+1)]"
        cell.usernameLabel.text = entries[indexPath.row].getUsername()
        cell.scoreLabel.text = String(entries[indexPath.row].getScore())
        
        // alternates the colour of every other row to style it like a bumble bee
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.systemYellow
        } else {
            cell.backgroundColor = UIColor.black
        }
        return cell
    }
}
