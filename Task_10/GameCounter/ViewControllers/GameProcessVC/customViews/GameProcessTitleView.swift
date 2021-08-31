//
//  TitleView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 30.08.2021.
//

import UIKit

class GameProcessTitleView: UIView {

    var titleText: String?
    var rightImage: UIImage?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleText ?? "No"
        label.textColor = UIColor.white
        label.font = UIFont(name: "nunito-extrabold", size: 36)
        return label
    }()
    
    private lazy var cubeImageView: UIImageView = {
        let image = UIImageView()
        image.image = rightImage ?? UIImage(named: "dice")
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(cubeImageView)
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }

    required init(coder: NSCoder) {
        fatalError("No storyboard emplimentation exist.")
    }
}

