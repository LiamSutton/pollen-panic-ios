//
//  LeaderboardEntry.swift
//  PollenPanic
//
//  Created by Liam Sutton on 05/03/2021.
//

import Foundation

// This class is used to model data for a valid leaderboard entry retrieved from the database
class LeaderBoardEntry {
    private var id:Int // The row id
    private var username:String // the username associated with the entry
    private var score:Int // the score assosicated with the entry
    
    init(id: Int, username: String, score:Int) {
        self.id = id
        self.username = username
        self.score = score
    }
    
    public func getId() -> Int {
        return self.id
    }
    
    public func getUsername() -> String {
        return self.username
    }
    
    public func getScore() -> Int {
        return self.score
    }
}
