//
//  ScoreModel.swift
//  PollenPanic
//
//  Created by Liam Sutton on 05/03/2021.
//

// Used to provide access to the current games state, IE; username and score so they can be added to the db
class ScoreModel {
    private var scoreData:ScoreData
    
    init() {
        scoreData=ScoreData()
    }
    
    open func getScoreData() -> ScoreData {
        return self.scoreData
    }
}
