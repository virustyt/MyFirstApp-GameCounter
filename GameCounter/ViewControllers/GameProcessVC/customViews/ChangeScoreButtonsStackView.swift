//
//  PlusScoreButtonsStackView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 10.09.2021.
//

import UIKit

class ChangeScoreButtonsStackView: UIStackView {
    
    lazy var plusFiveButton: ChangeScoreButton = {
        let button = ChangeScoreButton()
        button.setTextForAttributedString(text: "+5",fontSize: 25)
        return button
    }()
    
    lazy var plusTenButton: ChangeScoreButton = {
        let button = ChangeScoreButton()
        button.setTextForAttributedString(text: "+10",fontSize: 25)
        return button
    }()
    
    lazy var minusOneButton: ChangeScoreButton = {
        let button = ChangeScoreButton()
        button.setTextForAttributedString(text: "-1",fontSize: 25)
        return button
    }()
    
    lazy var minusFiveButton: ChangeScoreButton = {
        let button = ChangeScoreButton()
        button.setTextForAttributedString(text: "-5",fontSize: 25)
        return button
    }()
    
    lazy var minusTenButton: ChangeScoreButton = {
        let button = ChangeScoreButton()
        button.setTextForAttributedString(text: "-10",fontSize: 25)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(plusFiveButton)
        addArrangedSubview(plusTenButton)
        addArrangedSubview(minusOneButton)
        addArrangedSubview(minusFiveButton)
        addArrangedSubview(minusTenButton)
        distribution = .equalSpacing
        alignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plusFiveButton.heightAnchor.constraint(equalToConstant: 55),
            plusFiveButton.heightAnchor.constraint(equalTo: plusFiveButton.widthAnchor),
            
            plusTenButton.heightAnchor.constraint(equalToConstant: 55),
            plusTenButton.heightAnchor.constraint(equalTo: plusTenButton.widthAnchor),
            
            minusOneButton.heightAnchor.constraint(equalToConstant: 55),
            minusOneButton.heightAnchor.constraint(equalTo: minusOneButton.widthAnchor),
            
            minusFiveButton.heightAnchor.constraint(equalToConstant: 55),
            minusFiveButton.heightAnchor.constraint(equalTo: minusFiveButton.widthAnchor),
            
            minusTenButton.heightAnchor.constraint(equalToConstant: 55),
            minusTenButton.heightAnchor.constraint(equalTo: minusTenButton.widthAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
