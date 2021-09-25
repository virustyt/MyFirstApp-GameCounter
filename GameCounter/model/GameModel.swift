//
//  GameModel.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 27.08.2021.
//

import Foundation

class GameModel: Codable {
    static var shared = GameModel()
    
    var gameIsGoingOn = false
    var secondsPassed = 0
    var currentPlayer = 0
    
    var playersScores = [String : [Int]]()
    
    var allPlayers = [String]()
}


