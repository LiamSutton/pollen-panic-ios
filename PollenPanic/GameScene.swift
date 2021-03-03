//
//  GameScene.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit
class GameScene : SKScene {
    let player = SKSpriteNode(imageNamed: "bee.png")
    var currentDir:CGFloat = 0.0
    override func didMove(to view: SKView) {
        
        let leftSwipeGestureHandler = UISwipeGestureRecognizer(
            target: self, action: #selector(GameScene.handleLeftSwipeGesture(sender:))
        )
        
        let rightSwipeGestureHandler = UISwipeGestureRecognizer(
            target: self, action: #selector(GameScene.handleRightSwipeGesture(sender:))
        )
        
        let downSwipeGestureHandler = UISwipeGestureRecognizer(
            target: self, action: #selector(GameScene.handleDownSwipeGesture(sender:))
        )
        
        leftSwipeGestureHandler.direction = .left
        rightSwipeGestureHandler.direction = .right
        downSwipeGestureHandler.direction = .down
        
        view.addGestureRecognizer(leftSwipeGestureHandler)
        view.addGestureRecognizer(rightSwipeGestureHandler)
        view.addGestureRecognizer(downSwipeGestureHandler)
        
        backgroundColor = SKColor.systemTeal
        player.size = CGSize(width: 64, height: 64)
        player.position = CGPoint(x:size.width * 0.5, y: size.height * 0.1)
        
        addChild(player)
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.position.x += currentDir
    }
    
    @objc func handleLeftSwipeGesture (sender: UISwipeGestureRecognizer) {
        currentDir = -2.0
    }
    
    @objc func handleRightSwipeGesture (sender: UISwipeGestureRecognizer) {
        currentDir = 2.0
    }
    
    @objc func handleDownSwipeGesture (sender: UISwipeGestureRecognizer) {
        currentDir = 0.0
    }
}
