//
//  Collection.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

protocol Collection {
    var items:[GameObject] {get set}
    var furthestBackIndex:Int {get set}
    
    func populateCollection(n: Int)
    
    func move()
    
    func resetItemPosition(item: GameObject)
}
