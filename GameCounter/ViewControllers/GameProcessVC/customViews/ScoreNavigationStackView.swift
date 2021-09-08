//
//  ScoreNavigationStackView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 08.09.2021.
//

import UIKit

class ScoreNavigationStackView: UIStackView {

    private lazy var priviousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previous"), for: .normal)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "next"), for: .normal)
        return button
    }()
    
    private lazy var plusOneButton: UIButton = {
        let button = UIButton()
        let attributedText = NSAttributedString(string: "+1", attributes: [.foregroundColor: UIColor.white,
                                                                           .font: UIFont(name: "nunito-extrabold", size: 40) ?? UIFont.systemFont(ofSize: 40)])
        button.setAttributedTitle(attributedText, for: .normal)
        button.backgroundColor = UIColor.navigationBarButtonTextColor
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
            plusOneButton.heightAnchor.constraint(equalTo: plusOneButton.widthAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        plusOneButton.layer.cornerRadius = plusOneButton.frame.size.height / 2
//        plusOneButton.titleLabel?.textAlignment = .center
    }
}
