//
//  ScoreModel.swift
//  PollenPanic
//
//  Created by Liam Sutton on 05/03/2021.
//

class ScoreModel {
    private var scoreData:ScoreData
    
    init() {
        scoreData=ScoreData()
    }
    
    open func getScoreData() -> ScoreData {
        return self.scoreData
    }
}
