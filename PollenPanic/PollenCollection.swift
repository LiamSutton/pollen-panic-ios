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
    
    init(view: SKView) {
        self.items = []
        self.view = view
        self.gridSize = Int(view.bounds.size.width / 64)
        furthestBackIndex = 0
    }
    func populateCollection(n: Int) {
        var yPosition:CGFloat = view.bounds.size.height
        
        for _ in 0...n {
            let xPosition = CGFloat(Int.random(in: 0...gridSize) * 64) + 32
            self.items.append(Pollen(xPosition: xPosition, yPosition: yPosition))
            yPosition += Constants.POLLEN_DISTANCE
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
        furthestBackIndex = items.firstIndex(of: item)!
    }
    
    
}
