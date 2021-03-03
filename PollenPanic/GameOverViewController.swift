//
//  GameOverViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 01/03/2021.
//

import UIKit

class GameOverViewController : UIViewController {
    let beeFacts:[String] = ["Fact 1", "Fact 2", "Fact 3", "Fact 4"]
    @IBOutlet weak var beeFactLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        beeFactLabel.text = "Did you know: " + beeFacts.randomElement()! + "?"
    }
}
