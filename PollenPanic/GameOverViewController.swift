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
    let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        beeFactLabel.text = Constants.BEE_FACTS.randomElement()!
        let score:Int = appdelegate.scoreModel.getScoreData().getScore()
        scoreLabel.text = "Your score was: " + String(score)
        
    }
}
