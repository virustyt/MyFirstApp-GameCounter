//
//  GameModel.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 27.08.2021.
//

import Foundation

struct GameModel: Codable {
    static var shared = GameModel()
    
    var secondsPassed = 0
    
    var currentPlayer = 0
    
    var playersScores = [String : [Int]]()
    
    var allPlayers = ["Katy","John","Betty","Tom","Nick","Albert","July"]
    
    init(){
        playersScores["Katy"] = [0]
        playersScores["John"] = [0]
        playersScores["Tom"] = [0]
        playersScores["Nick"] = [0]
        playersScores["Albert"] = [0]
        playersScores["July"] = [0]
        playersScores["Betty"] = [0]
    }
}
