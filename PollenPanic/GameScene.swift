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
    var pollenCollection:PollenCollection?
    var pollutionCollection:PollutionCollection?
    var viewController:UIViewController?
    var score:Int = 0
    var scoreLabel:SKLabelNode?
    var gridSize:Int?
    var pollenPickupSfx: SKAudioNode!
    var gameOverSfx: SKAudioNode!
    var backgroundMusic : SKAudioNode!
    
    
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
        gridSize = (Int(view.bounds.size.width)-Constants.SPRITE_SIZE)/Constants.SPRITE_SIZE
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel?.text = String(score)
        scoreLabel?.fontSize = 46
        scoreLabel?.fontColor = SKColor.white
        scoreLabel?.position = CGPoint(x: frame.midX, y: view.bounds.height-150)
        pollenCollection = PollenCollection(view: view, gridSize: gridSize!)
        pollutionCollection = PollutionCollection(view: view, gridSize: gridSize!)
        setupBee()
        setupPollenCollection()
        setupPollutionCollection()
        addChild(scoreLabel!)
        
        if let backgroundMusicUrl = Bundle.main.url(forResource: Constants.BACKGROUND_MUSIC, withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: backgroundMusicUrl)
            addChild(backgroundMusic)
        }
        
        if let pollenPickupSfxUrl = Bundle.main.url(forResource: Constants.POLLEN_PICKUP_SFX, withExtension: "mp3") {
            pollenPickupSfx = SKAudioNode(url: pollenPickupSfxUrl)
            pollenPickupSfx.autoplayLooped = false
            addChild(pollenPickupSfx)
        }
        
        if let gameOverSfxUrl = Bundle.main.url(forResource: Constants.GAME_OVER_SFX, withExtension: "mp3") {
            gameOverSfx = SKAudioNode(url: gameOverSfxUrl)
            gameOverSfx.autoplayLooped = false
            addChild(gameOverSfx)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkAllCollisions()
        bee.move()
        pollenCollection!.move()
        pollutionCollection!.move()
        
        for item in pollenCollection!.items {
            if (item.position.y < 0) {
                pollenCollection?.resetItemPosition(item: item)
            }
        }
        
        for item in pollutionCollection!.items {
            if (item.position.y < 0) {
                pollutionCollection?.resetItemPosition(item: item)
            }
        }
    }
    
    func setupBee() {
        bee.size = CGSize(width: 64, height: 64)
        bee.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        
        let beeRange:SKRange = SKRange(lowerLimit: 32, upperLimit: frame.width-32)
        let beeConstraint:SKConstraint = SKConstraint.positionX(beeRange)
        
        addChild(bee)
        
        bee.constraints = [beeConstraint]
    }
    
    func setupPollenCollection() {
        pollenCollection?.populateCollection(n: 10)
        for item in pollenCollection!.items {
            addChild(item)
        }
    }
    
    func setupPollutionCollection() {
        pollutionCollection?.populateCollection(n: 10)
        for item in pollutionCollection!.items {
            addChild(item)
        }
    }
    
    func checkForCollision(bee: GameObject, obstacle: GameObject) -> Bool {
        return bee.intersects(obstacle)
    }
    
    func checkAllCollisions() {
        for item in pollenCollection!.items {
            let hasCollided:Bool = checkForCollision(bee: bee, obstacle: item)
            if (hasCollided) {
                pollenCollection?.resetItemPosition(item: item)
                score += Constants.SCORE_INCREASE
                pollenPickupSfx.run(SKAction.play())
                scoreLabel?.text = String(score)
            }
        }
        
        for item in pollutionCollection!.items {
            let hasCollided:Bool = checkForCollision(bee: bee, obstacle: item)
            if (hasCollided) {
                gameOverSfx.run(SKAction.play())
                pollutionCollection?.resetItemPosition(item: item)
                backgroundMusic.run(SKAction.stop())
                perform(#selector(gameOver), with: nil, afterDelay: 0.5)
            }
        }
    }
    // TODO: Fix memory leak, currently PISSING memory everywhere
    @objc func gameOver() {
        viewController?.performSegue(withIdentifier: "GameToGameOver", sender: self.view)
        view?.presentScene(nil)
        viewController=nil
        
        
        view?.presentScene(nil)
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
