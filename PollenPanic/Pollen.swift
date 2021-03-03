//
//  Pollen.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

class Pollen : SKSpriteNode {
    var initialPosition:CGPoint = CGPoint(x: 0, y: 0)
    init() {
        let texture = SKTexture(imageNamed: "pollen.png")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move() {
        self.position.y += Constants.DIRECTION_DOWN
    }
    
    func checkBounds(v: SKView) {
        if (self.position.y < 0) {
            self.position = initialPosition
        }
    }
}