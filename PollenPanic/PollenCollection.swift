//
//  PollenCollection.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

// Used to model an aggregation of pollen objects
class PollenCollection: Collection {
    var items: [GameObject]
    
    var furthestBackIndex: Int // index of the piece of pollen with the greatest current y position
    
    let view: SKView // reference to the current view its placed on
    let gridSize:Int // used to determine the spacing between objects
    
    // constructor
    init(view: SKView, gridSize: Int) {
        self.items = []
        self.view = view
        self.gridSize = gridSize
        furthestBackIndex = 0
    }
    
    // fill the items array with n objects
    func populateCollection(n: Int) {
        var yPosition:CGFloat = (view.bounds.size.height + Constants.HEIGHT_PADDING)
        for _ in 0...n {
            let gridIndex:Int = Int.random(in: 0...gridSize) // pick a random grid position to place on
            let xPosition:CGFloat = CGFloat((gridIndex*Constants.SPRITE_SIZE+Constants.HALF_SPRITE_SIZE))
            self.items.append(Pollen(xPosition: xPosition, yPosition: yPosition))
            yPosition+=Constants.POLLEN_DISTANCE // increase the distance the next piece of pollen will be placed
        }
        
        furthestBackIndex = self.items.count-1 // the furthest back object is automatically the last object added at runtime
    }
    
    // move all pieces of pollen in the aggregation by casting them as Moveable objects
    func move() {
        for item in items {
            if let moveableItem = item as? Moveable {
                moveableItem.move()
            }
        }
    }
    
    // move the pollen behind the furthest back piece of pollen then update the furthest back piece to be the one just moved
    func resetItemPosition(item: GameObject) {
        let furthestBack = self.items[furthestBackIndex]
        item.position.x = CGFloat(Int.random(in: 0...gridSize) * 64) + 32
        item.position.y = furthestBack.position.y + Constants.POLLEN_DISTANCE
        furthestBackIndex = self.items.firstIndex(of: item)!
    }
    
    
}
