//
//  FirstThreePlacesStackView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 23.09.2021.
//

import UIKit

class FirstThreePlacesStackView: UIStackView {
    
    private let firstSignLabel = UILabel()
    private let secondSignLabel = UILabel()
    private let thirdSignLabel = UILabel()
    private let firstPlayersScoreLabel = UILabel()
    private let secondPlayersScoreLabel = UILabel()
    private let thirdPlayersScoreLabel = UILabel()
    
    private enum PlayersPlace: Int{
        case first = 0
        case second
        case third
        
        var stringForCase: String{
            switch self {
            case .first:
                return "#1 "
            case .second:
                return "#2 "
            case .third:
                return "#3 "
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        distribution = .equalSpacing
        spacing = 15
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        loadTopThreePlayersData()
    }
        
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadTopThreePlayersData(){
        var playersTotalScores = [String:Int]()
        for (key,values) in GameModel.shared.playersScores {
            playersTotalScores[key] = values.reduce(0, {$0+$1} )
        }
        let playersSortedByScore = Array(playersTotalScores.keys).sorted( by: { playersTotalScores[$0]! == playersTotalScores[$1]! ? $0 < $1 : playersTotalScores[$0]! > playersTotalScores[$1]! } )
        let numberOfPlayers = playersSortedByScore.count
        let countOfTopPlayersToDisplay = numberOfPlayers < 3 ? numberOfPlayers : 3
        for playersIndex in 0...countOfTopPlayersToDisplay - 1 {
            let name = playersSortedByScore[playersIndex]
            guard let playersPlace =  PlayersPlace(rawValue: playersIndex) else { fatalError("Enum PlayersPLace does not contain such index for its raw value.") }
            setPlayersScore(score: playersTotalScores[name]!, for: name, with: playersPlace)
        }
    }
    
    private func setPlayersScore(score: Int, for player: String, with place: PlayersPlace){
        let placeAtributes:[NSAttributedString.Key: Any] = [.font:UIFont(name: "nunito-extrabold", size: 28) ?? UIFont(),
                                                           .foregroundColor: UIColor.white]
        let nameAtributes:[NSAttributedString.Key: Any] = [.font:UIFont(name: "nunito-extrabold", size: 28) ?? UIFont(),
                                                           .foregroundColor: UIColor.playersNameColorOrange]

        let atributedPlayersPlaceAndName = NSMutableAttributedString(string: place.stringForCase, attributes: placeAtributes)
        atributedPlayersPlaceAndName.append(NSAttributedString(string: player, attributes: nameAtributes))
        
        switch place {
        case .first:
            firstSignLabel.attributedText = atributedPlayersPlaceAndName
            firstPlayersScoreLabel.attributedText = NSAttributedString(string: "\(score)", attributes: placeAtributes)
        case .second:
            secondSignLabel.attributedText = atributedPlayersPlaceAndName
            secondPlayersScoreLabel.attributedText = NSAttributedString(string: "\(score)", attributes: placeAtributes)
        case .third:
            thirdSignLabel.attributedText = atributedPlayersPlaceAndName
            thirdPlayersScoreLabel.attributedText = NSAttributedString(string: "\(score)", attributes: placeAtributes)
        }
    }
    
    private func addSubviews() {
        
        let firstStack = UIStackView()
        firstStack.axis = .horizontal
        firstStack.distribution = .fill
        firstStack.addArrangedSubview(firstSignLabel)
        firstStack.addArrangedSubview(firstPlayersScoreLabel)
        firstPlayersScoreLabel.textAlignment = .right
        
        let secondStack = UIStackView()
        secondStack.axis = .horizontal
        secondStack.distribution = .fill
        secondStack.addArrangedSubview(secondSignLabel)
        secondStack.addArrangedSubview(secondPlayersScoreLabel)
        secondPlayersScoreLabel.textAlignment = .right
        
        let thirdStack = UIStackView()
        thirdStack.axis = .horizontal
        thirdStack.distribution = .fill
        thirdStack.addArrangedSubview(thirdSignLabel)
        thirdStack.addArrangedSubview(thirdPlayersScoreLabel)
        thirdPlayersScoreLabel.textAlignment = .right
        
        addArrangedSubview(firstStack)
        addArrangedSubview(secondStack)
        addArrangedSubview(thirdStack)
    }
}
