//
//  Pollen.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

// Class used to model a piece of pollen the player can pickup to increase their score
class Pollen : GameObject, Moveable{
    init(xPosition:CGFloat, yPosition:CGFloat) {
        super.init(imageNamed: Constants.POLLEN_SPRITE)
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
