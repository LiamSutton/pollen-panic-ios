//
//  Bee.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

// This class models the object the player will controll
class Bee : GameObject, Moveable {
    var currentDirection:CGFloat = Constants.DIRECTION_NONE
    
    init() {
        super.init(imageNamed: Constants.BEE_SPRITE);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // increase/decrease the x position by moving in the current direction
    func move() {
        self.position.x += currentDirection
    }
    
    // update the direction the bee should move in based on the argument passed
    func changeDirection(newDirection: CGFloat) {
        self.currentDirection = newDirection
    }
}
