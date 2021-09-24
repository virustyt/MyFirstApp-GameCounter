//
//  GameProcessTitleStackView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 30.08.2021.
//

import UIKit

class TitleStackView: UIStackView {

    var titleText: String?
    var rightImage: UIImage?
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = titleText ?? "Game"
        label.textColor = UIColor.white
        label.font = UIFont(name: "nunito-extrabold", size: 36)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var cubeImageView: UIButton = {
        let button = UIButton()
        button.setImage(rightImage ?? UIImage(named: "dice4"), for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.sizeToFit()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(titleLabel)
        addArrangedSubview(cubeImageView)
        alignment = .center
        distribution = .fill
        spacing = 5
        
        cubeImageView.widthAnchor.constraint(equalTo: cubeImageView.heightAnchor).isActive = true
        cubeImageView.heightAnchor.constraint(equalToConstant: titleLabel.font.capHeight).isActive = true
    }

    required init(coder: NSCoder) {
        fatalError("No storyboard emplimentation exist.")
    }
}
