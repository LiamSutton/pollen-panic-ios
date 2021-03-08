//
//  PollutionCollection.swift
//  PollenPanic
//
//  Created by Liam Sutton on 04/03/2021.
//

import SpriteKit

// Class used to model an aggregation of pollution objects
class PollutionCollection: Collection {
    var items: [GameObject]
    
    var furthestBackIndex: Int // the position of the piece of pollution with the heighest y position
    
    let view: SKView // reference to the view it is placed on
    let gridSize:Int // used to determine the distance between spawned objects
    
    // Constructor
    init(view: SKView, gridSize: Int) {
        self.items = []
        self.view = view
        self.gridSize = gridSize
        furthestBackIndex = 0
    }
    
    // fill the items array with n items spaced out behind eachother
    func populateCollection(n: Int) {
        // height plus rounded padding + initial starting position
        var yPosition:CGFloat = (view.bounds.size.height + Constants.HEIGHT_PADDING) + Constants.POLLUTION_STARTING_POSITION
        
        for _ in 0...n {
            let gridIndex:Int = Int.random(in: 0...gridSize) // pick a random grid position
            let xPosition:CGFloat = CGFloat((gridIndex*Constants.SPRITE_SIZE+Constants.HALF_SPRITE_SIZE))
            self.items.append(Pollution(xPosition: xPosition, yPosition: yPosition))
            yPosition+=Constants.POLLUTION_DISTANCE // increase the distance the next piece will be placed behind
        }
        
        furthestBackIndex = self.items.count-1
    }
    
    // Move every item in the aggreagation
    func move() {
        for item in items {
            if let moveableItem = item as? Moveable {
                moveableItem.move()
            }
        }
    }
    
    // if the pollution goes off screen, reset it by placing it behind the pollution with the currently highest y position
    func resetItemPosition(item: GameObject) {
        let furthestBack = self.items[furthestBackIndex]
        item.position.x = CGFloat(Int.random(in: 0...gridSize) * Constants.SPRITE_SIZE + Constants.HALF_SPRITE_SIZE)
        item.position.y = furthestBack.position.y + Constants.POLLUTION_DISTANCE
        furthestBackIndex = self.items.firstIndex(of: item)!
    }
    
    
}
