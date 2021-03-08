//
//  Pollution.swift
//  PollenPanic
//
//  Created by Liam Sutton on 04/03/2021.
//

import SpriteKit

class Pollution : GameObject, Moveable {
    var initialPosition:CGPoint = CGPoint(x: 0, y: 0)
    init(xPosition:CGFloat, yPosition:CGFloat) {
        super.init(imageNamed: Constants.POLLUTION_SPRITE)
        self.position = CGPoint(x: xPosition, y: yPosition)
        self.size = CGSize(width: Constants.SPRITE_SIZE, height: Constants.SPRITE_SIZE)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func move() {
        self.position.y += Constants.DIRECTION_DOWN
    }
    
}
