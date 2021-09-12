//
//  GameProcessTitleStackView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 30.08.2021.
//

import UIKit

class GameProcessTitleStackView: UIStackView {

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
    
    private lazy var cubeImageView: UIImageView = {
        let image = UIImageView()
        image.image = rightImage ?? UIImage(named: "dice")
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(titleLabel)
        addArrangedSubview(cubeImageView)
        alignment = .center
        distribution = .fill
        spacing = 5
    }

    required init(coder: NSCoder) {
        fatalError("No storyboard emplimentation exist.")
    }
}
