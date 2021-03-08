//
//  GameOverViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 01/03/2021.
//

import UIKit

class GameOverViewController : UIViewController {
    @IBOutlet weak var beeFactLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate // reference to score model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true // hide back button so they cannot return to the game directly
        
        // display a random bee fact and setup the UI
        beeFactLabel.text = Constants.BEE_FACTS.randomElement()!
        let score:Int = appdelegate.scoreModel.getScoreData().getScore()
        scoreLabel.text = "Your score was: " + String(score)
        
    }
}
