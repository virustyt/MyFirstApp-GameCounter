//
//  footerForPlayersNameTableView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 28.08.2021.
//

import UIKit

class footerForPlayersNameTableView: UITableViewHeaderFooterView {
    static let myReuseIdentifyer = String(describing: footerForPlayersNameTableView.self)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let universalSubview = UniversalView(frame: frame)
        universalSubview.translatesAutoresizingMaskIntoConstraints = false
        universalSubview.leftButton.setImage(UIImage(named: "Add"), for: .normal)
        universalSubview.playerNameLabel.text = "Add player"
        universalSubview.sortIconImageView.image = nil
        
        addSubview(universalSubview)
        NSLayoutConstraint.activate([
            universalSubview.topAnchor.constraint(equalTo: self.topAnchor),
            universalSubview.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: -1),
            universalSubview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            universalSubview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
