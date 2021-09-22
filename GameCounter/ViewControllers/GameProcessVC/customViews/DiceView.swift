//
//  DiceView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 22.09.2021.
//

import UIKit

class DiceView: UIView {

    func setNewRandomDiceToView(){
        let randomDiceNumber = arc4random() % 6 + 1
        diceImage.image = UIImage(named: "dice\(randomDiceNumber)")
    }
    
    private var diceImage: UIImageView = {
        let dice = UIImageView()
        let randomDiceNumber = arc4random() % 6 + 1
        print(randomDiceNumber)
        dice.image = UIImage(named: "dice\(randomDiceNumber)")
        dice.sizeToFit()
        dice.translatesAutoresizingMaskIntoConstraints = false
        return dice
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let blurEffect = UIBlurEffect(style: .regular)
        let bluredView = UIVisualEffectView(effect: blurEffect)
        bluredView.layer.opacity = 0.8
        bluredView.isOpaque = false
        addSubview(bluredView)
        bluredView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        addSubview(diceImage)
        diceImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        diceImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
