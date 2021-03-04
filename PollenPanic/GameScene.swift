//
//  GameScene.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//
import UIKit
import SpriteKit
class GameScene : SKScene {
    
    let bee = Bee()
    var pollen:PollenCollection?
    var pollution:PollutionCollection?
    var viewController:UIViewController?
    var score:Int = 0
    var scoreLabel:SKLabelNode?
    
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
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel?.text = String(score)
        scoreLabel?.fontSize = 46
        scoreLabel?.fontColor = SKColor.white
        scoreLabel?.position = CGPoint(x: frame.midX, y: view.bounds.height-200)
        pollen = PollenCollection(view: view)
        pollution = PollutionCollection(view: view)
        setupBee()
        setupPollenCollection()
        setupPollutionCollection()
        addChild(scoreLabel!)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkAllCollisions()
        bee.move()
        pollen!.move()
        pollution!.move()
        
        for item in pollen!.items {
            if (item.position.y < 0) {
                pollen?.resetItemPosition(item: item)
            }
        }
        
        for item in pollution!.items {
            if (item.position.y < 0) {
                pollution?.resetItemPosition(item: item)
            }
        }
    }
    
    func setupBee() {
        bee.size = CGSize(width: 64, height: 64)
        bee.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        addChild(bee)
    }
    
    func setupPollenCollection() {
        pollen?.populateCollection(n: 10)
        for item in pollen!.items {
            addChild(item)
        }
    }
    
    func setupPollutionCollection() {
        pollution?.populateCollection(n: 10)
        for item in pollution!.items {
            addChild(item)
        }
    }
    
    func checkForCollision(bee: GameObject, obstacle: GameObject) -> Bool {
        return bee.intersects(obstacle)
    }
    
    func checkAllCollisions() {
        for item in pollen!.items {
            let hasCollided:Bool = checkForCollision(bee: bee, obstacle: item)
            if (hasCollided) {
                pollen?.resetItemPosition(item: item)
                print("SCORE!")
                score += Constants.SCORE_INCREASE
                scoreLabel?.text = String(score)
            }
        }
        
        for item in pollution!.items {
            let hasCollided:Bool = checkForCollision(bee: bee, obstacle: item)
            if (hasCollided) {
                pollution?.resetItemPosition(item: item)
                print("DEAD!")
                scene?.isPaused = true
                let gameOverViewController = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
                                   
                    self.viewController?.navigationController?.pushViewController(gameOverViewController, animated: true)
                    self.viewController?.removeFromParent()
//                    self.viewController?.dismiss(animated: true, completion: nil)
                    self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil) // seems to fix the memory leak i think??
                    self.view?.presentScene(nil)
            }
        }
    }
   
    @objc func handleLeftSwipeGesture (sender: UISwipeGestureRecognizer) {
        bee.changeDirection(newDirection: Constants.DIRECTION_LEFT)
    }
    
    @objc func handleRightSwipeGesture (sender: UISwipeGestureRecognizer) {
        bee.changeDirection(newDirection: Constants.DIRECTION_RIGHT)
    }
    
    @objc func handleDownSwipeGesture (sender: UISwipeGestureRecognizer) {
        bee.changeDirection(newDirection: Constants.DIRECTION_NONE)
    }
    
}
