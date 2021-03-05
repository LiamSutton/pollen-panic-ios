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
    let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func HandleScoreSubmission(_ sender: Any) {
        let username:String = usernameInput.text!
        appdelegate.scoreModel.getScoreData().setUsername(username: username)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let score:Int = appdelegate.scoreModel.getScoreData().getScore()
        scoreLabel.text = "SCORE: " + String(score)
    }
}
