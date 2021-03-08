//
//  GameScene.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//
import UIKit
import SpriteKit

class GameScene : SKScene {
    
    var bee:Bee? // player object
    var pollenCollection:PollenCollection? // aggregation of pollen objects
    var pollutionCollection:PollutionCollection? // aggregation of pollution objects
    var viewController:UIViewController? // reference to the top level view controller
    var score:Int = 0 // reset score
    var scoreLabel:SKLabelNode? // label used to display current score
    var gridSize:Int? // grid size used to determine how many objects can be placed in a row
    var pollenPickupSfx: SKAudioNode! // sound played when pollen is picked up
    var gameOverSfx: SKAudioNode! // sound played when player dies and game ends
    var backgroundMusic : SKAudioNode! // background music played in continuous loop
    let appdelegate:AppDelegate = UIApplication.shared.delegate  as! AppDelegate // reference to score model
    
    
    override func didMove(to view: SKView) {
        setupGestures(view: view) // setup gestures to allow for player movement
        
        gridSize = (Int(frame.width)-Constants.SPRITE_SIZE)/Constants.SPRITE_SIZE // determine grid size
        
        // Initialise necessary objects
        bee = Bee()
        pollenCollection = PollenCollection(view: view, gridSize: gridSize!)
        pollutionCollection = PollutionCollection(view: view, gridSize: gridSize!)
        setupBackground()
        setupBee()
        setupPollenCollection()
        setupPollutionCollection()
        
        // configure sfx and ui elements
        setupSfx()
        setupUI()
    }
    
    // main game loop
    override func update(_ currentTime: TimeInterval) {
        checkAllCollisions() // see if any objects are colliding which could affect game state
        bee?.move() // move the player in the current direction
        pollenCollection!.move() // move all pollen objects downwards
        pollutionCollection!.move() // move all pollution objects downwards
        
        // if any pollen objects are off screen, reset them to the top
        for item in pollenCollection!.items {
            if (item.position.y < 0) {
                pollenCollection?.resetItemPosition(item: item)
            }
        }
        
        // if any pollution objects are off screen, reset them to the top
        for item in pollutionCollection!.items {
            if (item.position.y < 0) {
                pollutionCollection?.resetItemPosition(item: item)
            }
        }
    }
    
    // Initialise bee object and constrain it to the bounds of the screen
    func setupBee() {
        bee?.size = CGSize(width: 64, height: 64)
        bee?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        
        let beeRange:SKRange = SKRange(lowerLimit: 32, upperLimit: frame.width-32)
        let beeConstraint:SKConstraint = SKConstraint.positionX(beeRange)
        
        addChild(bee!)
        
        bee?.constraints = [beeConstraint]
    }
    
    // adds the ability for swipes to be detected and used to manipulate the players bee object
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
    
    // fill the pollen aggregation with n objects and add them to the scene
    func setupPollenCollection() {
        pollenCollection?.populateCollection(n: 10)
        for item in pollenCollection!.items {
            addChild(item)
        }
    }
    
    // fill the pollution aggregation with n objects and add them to the scene
    func setupPollutionCollection() {
        pollutionCollection?.populateCollection(n: 10)
        for item in pollutionCollection!.items {
            addChild(item)
        }
    }
    
    // setup a ui element to display the users current score and add it to the scene
    func setupUI() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel?.text = String(score)
        scoreLabel?.fontSize = 46
        scoreLabel?.fontColor = SKColor.white
        scoreLabel?.position = CGPoint(x: frame.midX, y: frame.height-150)
        addChild(scoreLabel!)
    }
    
    // checks for an intersection between a single bee and other gameobject
    func checkForCollision(bee: GameObject, obstacle: GameObject) -> Bool {
        return bee.intersects(obstacle)
    }
    
    // checks every object in the scene for collisions
    func checkAllCollisions() {
        for item in pollenCollection!.items {
            // if bee collides will pollen, incrememnt score and reset the pollen object
            let hasCollided:Bool = checkForCollision(bee: bee!, obstacle: item)
            if (hasCollided) {
                pollenCollection?.resetItemPosition(item: item)
                score += Constants.SCORE_INCREASE
                pollenPickupSfx.run(SKAction.play())
                scoreLabel?.text = String(score)
            }
        }
        
        for item in pollutionCollection!.items {
            // if bee collides with pollution, end the game and transition to the gameover view after a small delay
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
    
    // draws the background consisting of a blue background and two grass verges
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
    
    // initialises the sound effects played during the game loop
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
  
    // transition to the gameover view
    @objc func gameOver() {
        viewController?.performSegue(withIdentifier: "GameToGameOver", sender: self.view)
        view?.presentScene(nil)
        viewController=nil
        view?.presentScene(nil)
    }
    
    // used to move the bee to the left
    @objc func handleLeftSwipeGesture (sender: UISwipeGestureRecognizer) {
        bee?.changeDirection(newDirection: Constants.DIRECTION_LEFT)
    }
    
    // used to move the bee to the right
    @objc func handleRightSwipeGesture (sender: UISwipeGestureRecognizer) {
        bee?.changeDirection(newDirection: Constants.DIRECTION_RIGHT)
    }
    
    // used to make the bee stationary
    @objc func handleDownSwipeGesture (sender: UISwipeGestureRecognizer) {
        bee?.changeDirection(newDirection: Constants.DIRECTION_NONE)
    }
    
}
