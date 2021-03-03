//
//  GameOverViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 01/03/2021.
//

import UIKit

class GameOverViewController : UIViewController {
    @IBOutlet weak var beeFactLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        beeFactLabel.text = Constants.BEE_FACTS.randomElement()!
    }
}
