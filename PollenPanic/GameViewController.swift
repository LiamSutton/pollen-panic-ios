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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        
    }
}
