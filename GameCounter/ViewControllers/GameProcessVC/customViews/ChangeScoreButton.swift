//
//  ChangeScoreButton.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 10.09.2021.
//

import UIKit

class ChangeScoreButton: UIButton {
    
    func setTextForAttributedString(text: String, fontSize: CGFloat) {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        shadow.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1)
        let attributedText = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.white,
                                                                           .font: UIFont(name: "nunito-extrabold", size: fontSize) ?? UIFont.systemFont(ofSize: 40),
                                                                           .shadow: shadow])
        setAttributedTitle(attributedText, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.navigationBarButtonTextColor
        setTextForAttributedString(text: "No",fontSize: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
    }
}
