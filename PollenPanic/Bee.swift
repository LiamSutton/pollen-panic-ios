//
//  Bee.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

class Bee : SKSpriteNode {
    var currentDirection:CGFloat = Constants.DIRECTION_NONE
    
    init() {
        let texture = SKTexture(imageNamed: "bee.png")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move() {
        self.position.x += currentDirection
    }
    
    func changeDirection(newDirection: CGFloat) {
        self.currentDirection = newDirection
    }
}
