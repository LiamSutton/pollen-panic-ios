//
//  Collection.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//

import SpriteKit

/*
 This protocol is used to define a set of common methods that all objects who hold
 aggregations of gameobjects should implement
 */

protocol Collection {
    var items:[GameObject] {get set} // A list of gameobjects
    var furthestBackIndex:Int {get set} // the gameobject at the highest part of the screen
    func populateCollection(n: Int) // a method to instanciate a list of gameobjects
    func move() // used to move every item held in the list
    func resetItemPosition(item: GameObject) // move a gameobject to the top of the screen
}
