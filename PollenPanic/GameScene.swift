//
//  GameScene.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//
import UIKit
import SpriteKit

class GameScene : SKScene {
    
    var bee:Bee?
    var pollenCollection:PollenCollection?
    var pollutionCollection:PollutionCollection?
    var viewController:UIViewController?
    var score:Int = 0
    var scoreLabel:SKLabelNode?
    var gridSize:Int?
    var pollenPickupSfx: SKAudioNode!
    var gameOverSfx: SKAudioNode!
    var backgroundMusic : SKAudioNode!
    let appdelegate:AppDelegate = UIApplication.shared.delegate  as! AppDelegate
    
    
    override func didMove(to view: SKView) {
        
        
        setupGestures(view: view)
        
        gridSize = (Int(frame.width)-Constants.SPRITE_SIZE)/Constants.SPRITE_SIZE
        
        bee = Bee()
        pollenCollection = PollenCollection(view: view, gridSize: gridSize!)
        pollutionCollection = PollutionCollection(view: view, gridSize: gridSize!)
        setupBackground()
        setupBee()
        setupPollenCollection()
        setupPollutionCollection()
        
        
        setupSfx()
        setupUI()
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkAllCollisions()
        bee?.move()
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
        bee?.size = CGSize(width: 64, height: 64)
        bee?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        
        let beeRange:SKRange = SKRange(lowerLimit: 32, upperLimit: frame.width-32)
        let beeConstraint:SKConstraint = SKConstraint.positionX(beeRange)
        
        addChild(bee!)
        
        bee?.constraints = [beeConstraint]
    }
    
    func setupGestures(view: SKView) {
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
    
    func setupUI() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel?.text = String(score)
        scoreLabel?.fontSize = 46
        scoreLabel?.fontColor = SKColor.white
        scoreLabel?.position = CGPoint(x: frame.midX, y: frame.height-150)
        addChild(scoreLabel!)
    }
    
    func checkForCollision(bee: GameObject, obstacle: GameObject) -> Bool {
        return bee.intersects(obstacle)
    }
    
    func checkAllCollisions() {
        for item in pollenCollection!.items {
            let hasCollided:Bool = checkForCollision(bee: bee!, obstacle: item)
            if (hasCollided) {
                pollenCollection?.resetItemPosition(item: item)
                score += Constants.SCORE_INCREASE
                pollenPickupSfx.run(SKAction.play())
                scoreLabel?.text = String(score)
            }
        }
        
        for item in pollutionCollection!.items {
            let hasCollided:Bool = checkForCollision(bee: bee!, obstacle: item)
            if (hasCollided) {
                gameOverSfx.run(SKAction.play())
                pollutionCollection?.resetItemPosition(item: item)
                backgroundMusic.run(SKAction.stop())
                appdelegate.scoreModel.getScoreData().setScore(score: score)
                perform(#selector(gameOver), with: nil, afterDelay: 0.5)
            }
        }
    }
    
    func setupBackground() {
        backgroundColor = SKColor.systemTeal
        let grassLeft = SKShapeNode(rectOf: CGSize(width: 128, height: frame.height))
        grassLeft.fillColor = SKColor.init(red: 0.2, green: 0.6, blue: 0.2, alpha: 1.0)
        grassLeft.strokeColor = grassLeft.fillColor
        grassLeft.lineWidth = 2
        grassLeft.position = CGPoint(x: 32, y: frame.midY)
        
        let grassRight = SKShapeNode(rectOf: CGSize(width: 128, height: frame.height))
        grassRight.fillColor = grassLeft.fillColor
        grassRight.strokeColor = grassLeft.strokeColor
        grassRight.lineWidth = 2
        grassRight.position = CGPoint(x: frame.width-32, y: frame.midY)
        
        addChild(grassLeft)
        addChild(grassRight)
    }
    
    func setupSfx() {
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
  
    
    @objc func gameOver() {
        viewController?.performSegue(withIdentifier: "GameToGameOver", sender: self.view)
        view?.presentScene(nil)
        viewController=nil
        view?.presentScene(nil)
    }
    
    @objc func handleLeftSwipeGesture (sender: UISwipeGestureRecognizer) {
        bee?.changeDirection(newDirection: Constants.DIRECTION_LEFT)
    }
    
    @objc func handleRightSwipeGesture (sender: UISwipeGestureRecognizer) {
        bee?.changeDirection(newDirection: Constants.DIRECTION_RIGHT)
    }
    
    @objc func handleDownSwipeGesture (sender: UISwipeGestureRecognizer) {
        bee?.changeDirection(newDirection: Constants.DIRECTION_NONE)
    }
    
}
