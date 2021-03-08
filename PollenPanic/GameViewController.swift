//
//  GameViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 28/02/2021.
//

import UIKit
import SpriteKit

class GameViewController : UIViewController {
    
    @IBOutlet weak var swipeLabel: UILabel!
    
    // sets up the GameScene object and starts the game
    override func viewDidLoad() {
        super.viewDidLoad()
        // dissables the back button so the user cannot return to the main menu directly
        self.navigationItem.hidesBackButton = true
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
//        skView.showsFPS = true // Used for debugging
//        skView.showsNodeCount = true // Used for debugging

        scene.scaleMode = .aspectFill
        scene.viewController = self
        skView.presentScene(scene)
    }
}
