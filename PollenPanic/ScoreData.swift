//
//  Score.swift
//  PollenPanic
//
//  Created by Liam Sutton on 05/03/2021.
//

class ScoreData {
    private var username:String
    private var score:Int
    
    init() {
        self.username=""
        self.score=0
    }
    
    init(score: Int) {
        self.username=""
        self.score = score
    }
    
    public func getScore()->Int {
        return self.score
    }
    
    public func setScore(score: Int) {
        self.score = score
    }
    
    public func getUsername() -> String {
        return username
    }
    
    public func setUsername(username: String) {
        self.username = username
    }
}
