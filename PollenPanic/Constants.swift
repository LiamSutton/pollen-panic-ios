//
//  Constants.swift
//  PollenPanic
//
//  Created by Liam Sutton on 03/03/2021.
//
import SpriteKit

class Constants {
    
    // Constants defining directional movement speed
    static let DIRECTION_NONE:CGFloat = 0.0
    static let DIRECTION_LEFT:CGFloat = -4.0
    static let DIRECTION_RIGHT:CGFloat = 4.0
    static let DIRECTION_DOWN:CGFloat = -4.0
    
    // Constants denoting the distance at which objects should spawn from eachother
    static let HEIGHT_PADDING:CGFloat = 154
    static let POLLEN_DISTANCE:CGFloat = 500
    static let POLLUTION_STARTING_POSITION:CGFloat = 250
    static let POLLUTION_DISTANCE:CGFloat = 500
    
    static let SCORE_INCREASE:Int = 100
    
    static let HALF_SPRITE_SIZE:Int = 32
    static let SPRITE_SIZE:Int = 64
    
    // string id of sfx assets
    static let POLLEN_PICKUP_SFX:String = "pollenpickupsfx"
    static let GAME_OVER_SFX:String = "gameoversfx"
    static let BACKGROUND_MUSIC:String = "loopingbackgroundmusic"
    
    // string id of the database file
    static let DATABASE_FILE_NAME:String = "leaderboard.sqlite"
    
    // collection of bee facts to be presented at the game over screen
    static let BEE_FACTS:[String] =
        [
            "All worker bees are female",
            "A bee produces a teaspoon of honey in her lifetime",
            "The type of flower bees take their nectar from determines the honeys flavour",
            "Bees dont want to sting you as it will kill them",
            "To produce a kilogram of honey, bees fly the equivalent of three times around the world!",
            "Male bees (drones) have bigger eyes so they can find the queen easier",
            "A queen bee can produce 2,000 eggs a day!",
            "If a bee egg is fertilised it will be female, and if not it will be a male",
            "To get more bee's in your garden, add more colour to it!",
            "There are over 20,000 species of bee and they are found everywhere except Antarctica!",
            "The bee is the only social insect to be partically domesticated by humans"
        ]
}
