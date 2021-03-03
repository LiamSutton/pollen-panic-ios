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
    
    init() {
        self.items = []
    }
    func populateCollection(n: Int) {
        <#code#>
    }
    
    func move() {
        for item in items {
            if let moveableItem = item as? Moveable {
                moveableItem.move()
            }
        }
    }
    
    func resetItemPosition(item: GameObject) {
        <#code#>
    }
    
    
}
