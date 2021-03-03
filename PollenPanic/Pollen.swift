//
//  Pollen.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

class Pollen : GameObject, Moveable{
    var initialPosition:CGPoint = CGPoint(x: 0, y: 0)
    init(xPosition:CGFloat, yPosition:CGFloat) {
        super.init(imageNamed: "pollen.png")
        self.position = CGPoint(x: xPosition, y: yPosition)
        self.size = CGSize(width: 64, height: 64)
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
