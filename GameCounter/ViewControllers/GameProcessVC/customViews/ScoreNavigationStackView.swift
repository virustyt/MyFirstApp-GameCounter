//
//  ScoreNavigationStackView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 08.09.2021.
//

import UIKit

class ScoreNavigationStackView: UIStackView {

    lazy var priviousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previous"), for: .normal)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "next"), for: .normal)
        return button
    }()
    
    lazy var plusOneButton: ChangeScoreButton = {
        let button = ChangeScoreButton()
        button.setTextForAttributedString(text: "+1",fontSize: 40)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(priviousButton)
        addArrangedSubview(plusOneButton)
        addArrangedSubview(nextButton)
        distribution = .equalSpacing
        alignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plusOneButton.heightAnchor.constraint(equalToConstant: 90),
            plusOneButton.heightAnchor.constraint(equalTo: plusOneButton.widthAnchor),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
