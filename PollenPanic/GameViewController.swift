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
        
        let leftSwipeGestureHandler = UISwipeGestureRecognizer(
            target: self, action: #selector(handleLeftSwipeGesture(sender:))
        )
        
        let rightSwipeGestureHandler = UISwipeGestureRecognizer(
            target: self, action: #selector(handleRightSwipeGesture(sender:))
        )
        
        let downSwipeGestureHandler = UISwipeGestureRecognizer(
            target: self, action: #selector(handleDownSwipeGesture(sender:))
        )
        
        leftSwipeGestureHandler.direction = .left
        rightSwipeGestureHandler.direction = .right
        downSwipeGestureHandler.direction = .down
        
        self.view.addGestureRecognizer(leftSwipeGestureHandler)
        self.view.addGestureRecognizer(rightSwipeGestureHandler)
        self.view.addGestureRecognizer(downSwipeGestureHandler)
        
        if let view = self.view as? SKView {
            let scene = SKScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            let image = SKSpriteNode(imageNamed: "bee.png")
            image.size = CGSize(width: 64, height: 64)
            
            scene.addChild(image)
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            view.presentScene(scene)
        }
        
        
    }
    
    @objc func handleLeftSwipeGesture (sender: UISwipeGestureRecognizer) {
        
    }
    
    @objc func handleRightSwipeGesture (sender: UISwipeGestureRecognizer) {
        
    }
    
    @objc func handleDownSwipeGesture (sender: UISwipeGestureRecognizer) {
    }
}
