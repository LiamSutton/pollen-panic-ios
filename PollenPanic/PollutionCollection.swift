//
//  PollutionCollection.swift
//  PollenPanic
//
//  Created by Liam Sutton on 04/03/2021.
//

import SpriteKit

class PollutionCollection: Collection {
    var items: [GameObject]
    
    var furthestBackIndex: Int
    
    let view: SKView
    let gridSize:Int
    
    init(view: SKView, gridSize: Int) {
        self.items = []
        self.view = view
        self.gridSize = gridSize
        furthestBackIndex = 0
    }
    func populateCollection(n: Int) {
        var yPosition:CGFloat = (view.bounds.size.height + 154) + 250 // height plus rounded padding + initial starting position
        for _ in 0...n {
            let gridIndex:Int = Int.random(in: 0...gridSize)
            let xPosition:CGFloat = CGFloat((gridIndex*Constants.SPRITE_SIZE))+32
            self.items.append(Pollution(xPosition: xPosition, yPosition: yPosition))
            yPosition+=Constants.POLLUTION_DISTANCE
        }
        
        furthestBackIndex = self.items.count-1
    }
    
    func move() {
        for item in items {
            if let moveableItem = item as? Moveable {
                moveableItem.move()
            }
        }
    }
    
    func resetItemPosition(item: GameObject) {
        let furthestBack = self.items[furthestBackIndex]
        item.position.x = CGFloat(Int.random(in: 0...gridSize) * 64) + 32
        item.position.y = furthestBack.position.y + Constants.POLLUTION_DISTANCE
        furthestBackIndex = self.items.firstIndex(of: item)!
    }
    
    
}
