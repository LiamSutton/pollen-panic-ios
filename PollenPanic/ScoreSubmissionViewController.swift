//
//  ScoreSubmissionViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 05/03/2021.
//

import UIKit

class ScoreSubmissionViewController : UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var insertResultLabel: UILabel!
    @IBOutlet weak var submitScoreButton: UIButton!
    let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let db:DatabaseHelper = DatabaseHelper()
    
    // Insert a new row containing the current players score and username to the leaderboard database
    @IBAction func HandleScoreSubmission(_ sender: Any) {
        let textInput:String = usernameInput.text! // parse the text input
        
        appdelegate.scoreModel.getScoreData().setUsername(username: textInput) // update the score model
        
        let scoreData:ScoreData = appdelegate.scoreModel.getScoreData() // get the current score data from the model
        
        // parse the username and score
        let username:String = scoreData.getUsername()
        let score:Int = scoreData.getScore()
        
        // insert the data from the model into the db, returns true/false depending on the transaction result
        let inserted:Bool = db.insert(username: username, score: score)
        
        if (inserted) {
            insertResultLabel.text = "Score submitted"
            insertResultLabel.textColor = UIColor.systemGreen
            submitScoreButton.isEnabled = false
            
        } else {
            insertResultLabel.text = "Unable to submit score"
            insertResultLabel.textColor = UIColor.systemRed
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let score:Int = appdelegate.scoreModel.getScoreData().getScore()
        scoreLabel.text = "SCORE: " + String(score)
    }
}
