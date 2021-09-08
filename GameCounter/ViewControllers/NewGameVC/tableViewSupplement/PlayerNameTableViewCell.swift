//
//  PlayerNameTableViewCell.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 27.08.2021.
//

import UIKit

class PlayerNameTableViewCell: UITableViewCell {
    
    static let reuseIdentifyer = String(describing: self)
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) is impossible to execute - This project has no stiryboards.")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let universalSubview = UniversalView(frame: frame)
        universalSubview.translatesAutoresizingMaskIntoConstraints = false
        universalSubview.leftButton.setImage(UIImage(named: "delete"), for: .normal)
        universalSubview.playerNameLabel.text = "default name"
        universalSubview.sortIconImageView.image = UIImage(named: "humburger")
        
        addSubview(universalSubview)
        NSLayoutConstraint.activate([
            universalSubview.topAnchor.constraint(equalTo: self.topAnchor),
            universalSubview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            universalSubview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            universalSubview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
