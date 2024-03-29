//
//  GameObject.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

// This class is used as a base for all SkSpriteNodes in the game
class GameObject : SKSpriteNode {
    init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
