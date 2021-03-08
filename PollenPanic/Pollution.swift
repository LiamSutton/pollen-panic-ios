//
//  Pollution.swift
//  PollenPanic
//
//  Created by Liam Sutton on 04/03/2021.
//

import SpriteKit

// Class used to model a pollution object the player must avoid
class Pollution : GameObject, Moveable {
    init(xPosition:CGFloat, yPosition:CGFloat) {
        super.init(imageNamed: Constants.POLLUTION_SPRITE)
        self.position = CGPoint(x: xPosition, y: yPosition)
        self.size = CGSize(width: Constants.SPRITE_SIZE, height: Constants.SPRITE_SIZE)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // every frame move downwards at a constant speed
    func move() {
        self.position.y += Constants.DIRECTION_DOWN
    }
    
}
