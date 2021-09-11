//
//  UndoAndMinibarStack.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 10.09.2021.
//

import UIKit

class UndoAndMinibarStack: UIStackView {

    func setWhiteColorToCharachter(index: Int) {
        guard let text = playersNamesMinibar.attributedText, text.length != 0
        else {return}
        let attributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1),
                                                          .font: UIFont(name: "nunito-extrabold", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        let newText = NSMutableAttributedString(attributedString: text)
        newText.addAttributes(attributes, range: NSRange(location: 0, length: newText.length))
        let locationOfLetter = index * 2
        newText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: locationOfLetter, length: 1))
        playersNamesMinibar.attributedText = newText
    }
    
    lazy var undoButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "undo"), for: .normal)
            button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            return button
        }()

    lazy var playersNamesMinibar: UILabel = {
          let label = UILabel()
            let attributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1),
                                                              .font: UIFont(name: "nunito-extrabold", size: 20) ?? UIFont.systemFont(ofSize: 20)]
            label.textAlignment = .center
            var minibarText = ""
            for playerName in GameModel.shared.allPlayers {
                minibarText += String(playerName.first!) + " "
            }
            label.attributedText = NSAttributedString(string: minibarText, attributes: attributes)
            label.setContentHuggingPriority(.defaultLow, for: .horizontal)
            return label
        }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(undoButton)
        addArrangedSubview(playersNamesMinibar)
        distribution = .fill
        alignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        setWhiteColorToCharachter(index: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
