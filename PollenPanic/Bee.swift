//
//  Bee.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

class Bee : GameObject, Moveable {
    var currentDirection:CGFloat = Constants.DIRECTION_NONE
    
    init() {
        super.init(imageNamed: "bee.png");
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
