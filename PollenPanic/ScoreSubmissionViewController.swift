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
    
    // TODO: Tidy up this shite
    @IBAction func HandleScoreSubmission(_ sender: Any) {
        let username:String = usernameInput.text!
        appdelegate.scoreModel.getScoreData().setUsername(username: username)
        let inserted:Bool = db.insert(username: appdelegate.scoreModel.getScoreData().getUsername(), score: appdelegate.scoreModel.getScoreData().getScore())
        
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
