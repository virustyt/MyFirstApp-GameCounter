//
//  GameModel.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 27.08.2021.
//

import Foundation

struct GameModel {
    static var shared = GameModel()
    
    var playersScores = [String : Int]()
    
    var allPlayers = ["Katy","John","Betty"]
    
    init(){
        playersScores["Katy"] = 20
        playersScores["John"] = 15
        playersScores["Betty"] = 0
    }
    
    
}
