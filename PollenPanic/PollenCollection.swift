//
//  PollenCollection.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

class PollenCollection: Collection {
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
        var yPosition:CGFloat = (view.bounds.size.height + Constants.HEIGHT_PADDING)
        for _ in 0...n {
            let gridIndex:Int = Int.random(in: 0...gridSize)
            let xPosition:CGFloat = CGFloat((gridIndex*Constants.SPRITE_SIZE+Constants.HALF_SPRITE_SIZE))
            self.items.append(Pollen(xPosition: xPosition, yPosition: yPosition))
            yPosition+=Constants.POLLEN_DISTANCE
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
        item.position.y = furthestBack.position.y + Constants.POLLEN_DISTANCE
        furthestBackIndex = self.items.firstIndex(of: item)!
    }
    
    
}
