//
//  LeaderboardEntry.swift
//  PollenPanic
//
//  Created by Liam Sutton on 05/03/2021.
//

import Foundation

class LeaderBoardEntry {
    private var id:Int
    private var username:String
    private var score:Int
    
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
